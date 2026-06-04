using BenchmarkTools
using Random
using Statistics
using DifferentialEquations
using DelayEmbeddings
include("../Norberts_RQA_Code/RPLineLengths.jl")
include("my_sampling.jl")

"""
    Klasse 1 Systeme - Chaos (low- and high-dimensional)
    -
    Systems:
    Roessler system (low-dimensional chaos)
    -
    Tests:
    Original (norberts RPLineLengths.jl)
    RPLL-based sampling alternatives

"""
# %%
"""
    Roessler-system (low-dimensional chaos)
    -
    Test:
    Original
    memory-sampling (RPLL based)
"""
# Create exemplary data (Roessler)
function roessler!(du, u, p, t)
    du[1] = -u[2] - u[3]
    du[2] = u[1] + a * u[2]
    du[3] = 0.2 + u[3] * (u[1] - 5.7)
end

N = 10000                             # length of final time series
N_trans = 100                         # transients to be removed from time series
a = 0.2                               # control parameter in the Roessler system
ΔT = 0.2                              # sampling time
u0 = [-6.2668, -1.3413, 0.0166]       # initial conditions

prob = ODEProblem(roessler!, u0, (0.0, (N + N_trans - 1) * ΔT)) # problem statement for the solver
sol = solve(prob, Tsit5(), saveat=ΔT) # solving ODEs
x = transpose(hcat(sol.u...))         # get solution as a matrix
x = x[N_trans+1:end, :]               # remove transients

# RQA estimation
ε = 0.1 * (maximum(x) - minimum(x))   # recurrence threshold value
M = Int(round(0.2 * N))               # number of random subsamples

# ====================================================================
# Benchmarking random-sampling approaches with Seed and w/o Seed
# ====================================================================
# @time histL_norbert, N_norbert = get_hist_diagonal_sampled(x, ε, M); # calculation using sampling schema
# @time histL_mem, N_mem = get_hist_diagonal_memory_sampled(x, ε, M); # calc using memory sampling approach (basis RPLL)

# w/o Seed

b_mem = @benchmark get_hist_diagonal_memory_sampled($x, $ε, $M); # benchmarking w/o seed
b_norbert = @benchmark get_hist_diagonal_sampled($x, $ε, $M); 

runtime_mem    = median(b_mem.times) / 1e6 # times ist in Nanosekunden, Umrechnung in Millisekunden
allocations_mem = b_mem.allocs
storage_mem    = b_mem.memory / 1024       # memory ist in Bytes, Umrechnung in KiB

runtime_norbert    = median(b_norbert.times) / 1e6 # times ist in Nanosekunden, Umrechnung in Millisekunden
allocations_norbert = b_norbert.allocs
storage_norbert    = b_norbert.memory / 1024       # memory ist in Bytes, Umrechnung in KiB




# With seed

b_mem = @benchmark get_hist_diagonal_memory_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1; # benchmarking with seed and evals =1 assuming that the algo takes long enough in one calculation anyways
b_norbert = @benchmark get_hist_diagonal_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1; 

runtime_seed_mem    = median(b_mem.times) / 1e6 # times ist in Nanosekunden, Umrechnung in Millisekunden und median, wegen Ausreißern (wegen hintergrundprozessen auf dem selben PC)
allocations_seed_mem = b_mem.allocs
storage_seed_mem    = b_mem.memory / 1024       # memory ist in Bytes, Umrechnung in KiB

runtime_seed_norbert    = median(b_norbert.times) / 1e6 # times ist in Nanosekunden, Umrechnung in Millisekunden
allocations_seed_norbert = b_norbert.allocs
storage_seed_norbert    = b_norbert.memory / 1024       # memory ist in Bytes, Umrechnung in KiB

Random.seed!(42)
histL_seed_mem, countAll_seed_mem = get_hist_diagonal_memory_sampled(x, ε, M)

rqa_seed_mem = rqa(histL_seed_mem, countAll_seed_mem)

Random.seed!(42)
histL_seed_norbert, countAll_seed_norbert = get_hist_diagonal_sampled(x, ε, M)  

rqa_seed_norbert = rqa(histL_seed_norbert, countAll_seed_norbert)

# ====================================================================
# Benchmarking non-random sampling approaches
# ====================================================================



# ====================================================================
# Benchmarking non-sampling approaches
# ====================================================================

b_woRP = @benchmark get_hist_diagonal_woRP($x, $ε); 

runtime_woRP    = median(b_woRP.times) / 1e6 # times ist in Nanosekunden, Umrechnung in Millisekunden
allocations_woRP = b_woRP.allocs
storage_woRP    = b_woRP.memory / 1024       # memory ist in Bytes, Umrechnung in KiB

# ====================================================================
# RQA measures and countALl for random-sampling w/o seed
# ====================================================================

# Loop to determine countAll mean, because benchmark does not save values and seed gives always same vals?!
countAll_history_memory_samp = zeros(Int, 1000)
countAll_history_norbert = zeros(Int, 1000)

# Loop for mean vals of RR, DET, L, ENTR (w/o seed)

histL_woRP = get_hist_diagonal_woRP(x, ε); # baseline/correct-vals
rqa_woRP = rqa(histL_woRP, N * (N - 1) / 2)


RR_history_memory_samp = zeros(Float64, 1000)
RR_history_norbert = zeros(Float64, 1000)

DET_history_memory_samp = zeros(Float64, 1000)
DET_history_norbert = zeros(Float64, 1000)

L_history_memory_samp = zeros(Float64, 1000)
L_history_norbert = zeros(Float64, 1000)

ENTR_history_memory_samp = zeros(Float64, 1000)
ENTR_history_norbert = zeros(Float64, 1000)

for n in 1:1000
    histL_mem, N_mem = get_hist_diagonal_memory_sampled(x, ε, M);
    histL_norbert, N_norbert = get_hist_diagonal_sampled(x, ε, M);

    countAll_history_memory_samp[n] = N_mem
    countAll_history_norbert[n] = N_norbert

    rqa_mem = rqa(histL_mem, N_mem)
    rqa_norbert = rqa(histL_norbert, N_norbert)

    RR_history_memory_samp[n] = rqa_mem[1]
    RR_history_norbert[n] = rqa_norbert[1]

    DET_history_memory_samp[n] = rqa_mem[2]
    DET_history_norbert[n] = rqa_norbert[2]

    L_history_memory_samp[n] = rqa_mem[3]
    L_history_norbert[n] = rqa_norbert[3]

    ENTR_history_memory_samp[n] = rqa_mem[4]
    ENTR_history_norbert[n] = rqa_norbert[4]
end

mean_countAll_memory_samp = mean(countAll_history_memory_samp)
mean_countAll_norbert = mean(countAll_history_norbert)

std_countAll_memory_samp = std(countAll_history_memory_samp)
std_countAll_norbert = std(countAll_history_norbert)


mean_RR_memory_samp = mean(RR_history_memory_samp)
mean_RR_norbert = mean(RR_history_norbert)

mean_DET_memory_samp = mean(DET_history_memory_samp)
mean_DET_norbert = mean(DET_history_norbert)

mean_L_memory_samp = mean(L_history_memory_samp)
mean_L_norbert = mean(L_history_norbert)

mean_ENTR_memory_samp = mean(ENTR_history_memory_samp)
mean_ENTR_norbert = mean(ENTR_history_norbert)

std_RR_memory_samp = std(RR_history_memory_samp)
std_RR_norbert = std(RR_history_norbert)

std_DET_memory_samp = std(DET_history_memory_samp)
std_DET_norbert = std(DET_history_norbert)

std_L_memory_samp = std(L_history_memory_samp)
std_L_norbert = std(L_history_norbert)

std_ENTR_memory_samp = std(ENTR_history_memory_samp)
std_ENTR_norbert = std(ENTR_history_norbert)

# ====================================================================
# Ausgaben
# ====================================================================

println("=== PERFORMANCE W/O seed - memory sampling ===")
println("runtime:    ", round(runtime_mem, digits=2), " ms")
println("allocations: ", allocations_mem)
println("storage:    ", round(storage_mem, digits=2), " KiB")
println("countAll: ", round(mean_countAll_memory_samp, digits=2), " ± ", round(std_countAll_memory_samp, digits=2))
println("RR: ", mean_RR_memory_samp, " ± ", std_RR_memory_samp)
println("DET: ", mean_DET_memory_samp, " ± ", std_DET_memory_samp)
println("L: ", mean_L_memory_samp, " ± ", std_L_memory_samp)
println("ENTR: ", mean_ENTR_memory_samp, " ± ", std_ENTR_memory_samp)

println("=== PERFORMANCE W/O seed - norberts sampling ===")
println("runtime:    ", round(runtime_norbert, digits=2), " ms")
println("allocations: ", allocations_norbert)
println("storage:    ", round(storage_norbert, digits=2), " KiB")
println("countAll: ", round(mean_countAll_norbert, digits=2), " ± ", round(std_countAll_norbert, digits=2))
println("RR: ", mean_RR_norbert, " ± ", std_RR_norbert)
println("DET: ", mean_DET_norbert, " ± ", std_DET_norbert)
println("L: ", mean_L_norbert, " ± ", std_L_norbert)
println("ENTR: ", mean_ENTR_norbert, " ± ", std_ENTR_norbert)

println("=== PERFORMANCE WITH seed - memory sampling ===")
println("runtime:    ", round(runtime_seed_mem, digits=2), " ms")
println("allocations: ", allocations_seed_mem)
println("storage:    ", round(storage_seed_mem, digits=2), " KiB")
println("countAll:    ", countAll_seed_mem)
println("RR: ", rqa_seed_mem[1])
println("DET: ", rqa_seed_mem[2])
println("L: ", rqa_seed_mem[3])
println("ENTR: ", rqa_seed_mem[4])

println("=== PERFORMANCE WITH seed - norberts sampling ===")
println("runtime:    ", round(runtime_seed_norbert, digits=2), " ms")
println("allocations: ", allocations_seed_norbert)
println("storage:    ", round(storage_seed_norbert, digits=2), " KiB")
println("countAll:    ", countAll_seed_norbert)
println("RR: ", rqa_seed_norbert[1])
println("DET: ", rqa_seed_norbert[2])
println("L: ", rqa_seed_norbert[3])
println("ENTR: ", rqa_seed_norbert[4])

println("=== PERFORMANCE - woRP ===")
println("runtime:    ", round(runtime_woRP, digits=2), " ms")
println("allocations: ", allocations_woRP)
println("storage:    ", round(storage_woRP, digits=2), " KiB")
println("countAll: -   ")
println("RR: ", rqa_woRP[1])
println("DET: ", rqa_woRP[2])
println("L: ", rqa_woRP[3])
println("ENTR: ", rqa_woRP[4])
# 
# println("runtime:    ", round(runtime_seed_norbert, digits=2), " ms")
# println("allocations: ", allocations_seed_norbert)
# println("storage:    ", round(storage_seed_norbert, digits=2), " KiB")
# println("=== PERFORMANCE ?WITH seed? - microstates ===")
# println("countAll:    ", countAll_seed_norbert)
# println("RR: ", r0.RR)
# println("DET: ", r0.DET)
# println("L: ", r0.L)
# println("ENTR: ", r0.ENTR)
# 
"""
Klasse 2 Systeme - Periodic ?(low- and high-dimensional)?
    -
    Tests 
"""

# %%
"""

"""



"""
Klasse 3 Systeme - Homogenous RP 
    -
    Tests 
"""

# %%
"""

"""



"""
Klasse 4 Systeme - Real data (Time Series)
    -
    Tests 
"""

# %%
"""

"""



"""
Klasse 5 Systeme - Drift
    -
    Tests 
"""

# %%
"""

"""