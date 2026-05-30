using BenchmarkTools
using DifferentialEquations
using DelayEmbeddings
using Statistics
include("../Norberts_RQA_Code/RPLineLengths.jl")
include("my_sampling.jl")

"""
    Klasse 1 Systeme - Chaos (low- and high-dimensional)
    -
    Tests 
"""
# %%
"""
    Roessler-system (low-dimensional chaos)
    -
    Test:
    memory_sampling (basis RPLL) vs sampled (RPLL)
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

# Get histograms of line lengths timed
@time histL_mem, N_mem = get_hist_diagonal_memory_sampled(x, ε, M); # calc using memory sampling approach (basis RPLL)
@time histL_norbert, N_norbert = get_hist_diagonal_sampled(x, ε, M); # calculation using sampling schema

# Get histograms of line lengths benchmarked timed
@btime histL_mem, N_mem = get_hist_diagonal_memory_sampled($x, $ε, $M); # calc using memory sampling approach (basis RPLL)
@btime histL_norbert, N_norbert = get_hist_diagonal_sampled($x, $ε, $M); # calculation using sampling schema

# Get RQA measures
r1 = rqa(histL_mem, N_mem)     # RQA using standard approach
r2 = rqa(histL_norbert, N_norbert)                # RQA using sampling approach

print(r1, "\n", r2,)



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