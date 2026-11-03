using BenchmarkTools
using Random
using Statistics
using DifferentialEquations
using DelayEmbeddings
using StaticArrays

include("../Norberts_RQA_Code/RPLineLengths.jl")
include("my_sampling.jl")

# ====================================================================
# 1. High-Performance Utility: Matrix (N, D) -> Vector{SVector{D, Float64}}
# ====================================================================
@inline function to_svec(x_mat::Matrix{Float64})
    D = size(x_mat, 2)
    # Transponieren stellt sicher, dass Koordinaten spaltenweise zusammenhängen (Fortran-Layout)
    return reinterpret(reshape, SVector{D, Float64}, copy(transpose(x_mat)))
end

# ====================================================================
# 2. Zentrale Evaluierungs-Funktion (Single-Point-of-Truth Benchmark)
# ====================================================================
function evaluate_system(
    system_name::String, 
    x_mat::Matrix{Float64}, 
    ε::Float64, 
    M::Int; 
    run_norb::Bool = true,
    n_stat::Int = 1000
)
    println("\n" * "="^72)
    println(" SYSTEM: $system_name")
    println("="^72)
    
    N_val = size(x_mat, 1)
    total_pairs = round(Int, N_val * (N_val - 1) / 2)

    # Reinterpretation für SVector-basierte Hybride (0 Extra-Allokation bei Zugriff)
    x_svec = to_svec(x_mat)

    # --- Baseline (woRP) ---
    histL_woRP = get_hist_diagonal_woRP(x_mat, ε)
    rqa_woRP   = rqa(histL_woRP, total_pairs)
    b_woRP     = @benchmark get_hist_diagonal_woRP($x_mat, $ε)

    t_woRP = round(median(b_woRP.times) / 1e6, digits=2)
    println("\n--- BASELINE: woRP ---")
    println("Runtime: $t_woRP ms")
    println("Allocs:  $(b_woRP.allocs)")
    println("Mem:     $(round(b_woRP.memory / 1024, digits=2)) KiB")
    println("RR:      $(round(rqa_woRP[1], digits=4))")
    println("DET:     $(round(rqa_woRP[2], digits=4))")
    println("L:       $(round(rqa_woRP[3], digits=4))")
    println("ENTR:    $(round(rqa_woRP[4], digits=4))")

    # --- Zu testende Methoden ---
    # Korrektur: Norbert erwartet nun :svec, da die Methode so definiert ist
    methods = [
        ("Norbert (Standard)",                   :svec, run_norb, data -> get_hist_diagonal_sampled(data, ε, M)),
        ("SMI LFBOTH",                           :mat,  true,     data -> get_hist_diagonal_importance_stratified_memory_sampled_LFboth(data, ε, M)),
        ("Hybrid1 (dep + womf + wnlfb)",         :svec, true,     data -> hybrid1_dep_wnlfb(data, ε, M))
    ]

    # Allokationsfreie Stat-Buffer für Monte-Carlo
    rr_stat   = Vector{Float64}(undef, n_stat)
    det_stat  = Vector{Float64}(undef, n_stat)
    l_stat    = Vector{Float64}(undef, n_stat)
    entr_stat = Vector{Float64}(undef, n_stat)
    cnt_stat  = Vector{Int}(undef, n_stat)

    for (name, data_type, active, func) in methods
        !active && continue
        
        data = data_type == :svec ? x_svec : x_mat
        println("\n>>> EVALUATING: $name <<<")

        # 1. Benchmarking
        b_woseed = @benchmark $func($data)
        b_seed   = @benchmark $func($data) setup=(Random.seed!(42)) evals=1

        t_woseed = round(median(b_woseed.times) / 1e6, digits=2)
        t_seed   = round(median(b_seed.times) / 1e6, digits=2)
        println("  [Benchmark W/O Seed]   $t_woseed ms | Allocs: $(b_woseed.allocs) | Mem: $(round(b_woseed.memory / 1024, digits=2)) KiB")
        println("  [Benchmark WITH Seed]  $t_seed ms | Allocs: $(b_seed.allocs) | Mem: $(round(b_seed.memory / 1024, digits=2)) KiB")

        # 2. Seed Run (Seed 42)
        Random.seed!(42)
        h_seed, c_seed = func(data)
        rqa_s = rqa(h_seed, c_seed)

        println("  [Exakt Seed 42]        countAll: $c_seed")
        println("    RR:   $(round(rqa_s[1], digits=4)) (Δ: $(round(rqa_s[1] - rqa_woRP[1], digits=5)))")
        println("    DET:  $(round(rqa_s[2], digits=4)) (Δ: $(round(rqa_s[2] - rqa_woRP[2], digits=5)))")
        println("    L:    $(round(rqa_s[3], digits=4)) (Δ: $(round(rqa_s[3] - rqa_woRP[3], digits=5)))")
        println("    ENTR: $(round(rqa_s[4], digits=4)) (Δ: $(round(rqa_s[4] - rqa_woRP[4], digits=5)))")

        # 3. Monte-Carlo Läufe (mit @inbounds optimiert)
        @inbounds for n in 1:n_stat
            h_st, c_st = func(data)
            cnt_stat[n] = c_st
            r_st = rqa(h_st, c_st)
            rr_stat[n]   = r_st[1]
            det_stat[n]  = r_st[2]
            l_stat[n]    = r_st[3]
            entr_stat[n] = r_st[4]
        end

        println("  [Statistisch $n_stat Läufe]")
        println("    countAll: $(round(mean(cnt_stat), digits=1)) ± $(round(std(cnt_stat), digits=1))")
        println("    RR:   $(round(mean(rr_stat), digits=4)) ± $(round(std(rr_stat), digits=5)) (Δ: $(round(mean(rr_stat) - rqa_woRP[1], digits=5)))")
        println("    DET:  $(round(mean(det_stat), digits=4)) ± $(round(std(det_stat), digits=5)) (Δ: $(round(mean(det_stat) - rqa_woRP[2], digits=5)))")
        println("    L:    $(round(mean(l_stat), digits=4)) ± $(round(std(l_stat), digits=5)) (Δ: $(round(mean(l_stat) - rqa_woRP[3], digits=5)))")
        println("    ENTR: $(round(mean(entr_stat), digits=4)) ± $(round(std(entr_stat), digits=5)) (Δ: $(round(mean(entr_stat) - rqa_woRP[4], digits=5)))")
    end
end

# ====================================================================
# 3. Datengenerierung & Ausführung
# ====================================================================
N_points = 10000
M_default = Int(round(0.2 * N_points))

# ---------------------------------------------------------
# KLASSE 1: CHAOS (ROESSLER SYSTEM) - dim = 3
# ---------------------------------------------------------
function roessler!(du, u, p, t)
    du[1] = -u[2] - u[3]
    du[2] = u[1] + 0.2 * u[2]
    du[3] = 0.2 + u[3] * (u[1] - 5.7)
end

prob_r = ODEProblem(roessler!, [-6.2668, -1.3413, 0.0166], (0.0, (N_points + 100 - 1) * 0.2)) 
sol_r  = solve(prob_r, Tsit5(), saveat=0.2) 
x_c1   = copy(transpose(reduce(hcat, sol_r.u)))[101:end, :]

ε_c1 = 0.1 * (maximum(x_c1) - minimum(x_c1))   
evaluate_system("KLASSE 1: CHAOS (ROESSLER SYSTEM)", x_c1, ε_c1, M_default; run_norb=true)

# ---------------------------------------------------------
# KLASSE 1: CHAOS (LORENZ SYSTEM) - dim = 3
# ---------------------------------------------------------
function generate_lorenz(N; dt=0.01, σ=10.0, ρ=28.0, β=8/3)
    x = zeros(Float64, N, 3)
    x[1, :] .= [1.0, 1.0, 1.0] 
    @inbounds for i in 1:(N-1)
        dx = σ * (x[i,2] - x[i,1])
        dy = x[i,1] * (ρ - x[i,3]) - x[i,2]
        dz = x[i,1] * x[i,2] - β * x[i,3]
        x[i+1, 1] = x[i,1] + dx * dt
        x[i+1, 2] = x[i,2] + dy * dt
        x[i+1, 3] = x[i,3] + dz * dt
    end
    return x
end

x_lorenz = generate_lorenz(N_points)
ε_lorenz = 0.1 * (maximum(x_lorenz) - minimum(x_lorenz))   
evaluate_system("KLASSE 1: CHAOS (LORENZ SYSTEM)", x_lorenz, ε_lorenz, M_default; run_norb=true)

# ---------------------------------------------------------
# KLASSE 2: PERIODISCHE SYSTEME
# ---------------------------------------------------------
# 2a) Bad Embedding (dim = 1)
t_h1 = range(0, step=0.1, length=N_points)
x_h1 = reshape(sin.(t_h1), :, 1)
ε_h1 = 0.1 * (maximum(x_h1) - minimum(x_h1)) 
evaluate_system("KLASSE 2: BE+PD PERIODIC (HARMONIC OSCILLATOR)", x_h1, ε_h1, M_default; run_norb=true)

# 2b) Glatt / Glattes PD (dim = 2) -> Norbert überspringen
t_h2 = range(0, step=0.1, length=N_points)
x_h2 = hcat(sin.(t_h2), cos.(t_h2))
ε_h2 = 0.1 * (maximum(x_h2) - minimum(x_h2))   
evaluate_system("KLASSE 2: PD(unrecognizable) PERIODIC", x_h2, ε_h2, M_default; run_norb=false)

# 2c) Rauschen (dim = 2)
Random.seed!(123)
t_h3 = range(0, step=0.1, length=N_points)
x_h3 = hcat(sin.(t_h3), cos.(t_h3)) .+ 0.05 .* randn(N_points, 2)
ε_h3 = 0.1 * (maximum(x_h3) - minimum(x_h3))   
evaluate_system("KLASSE 2: PD(noise) PERIODIC", x_h3, ε_h3, M_default; run_norb=true)

# 2d) Quasiperiodisch (dim = 2)
t_h4 = range(0, step=0.1, length=N_points)
x_h4 = hcat(sin.(t_h4) .+ sin.(sqrt(2).*t_h4), cos.(t_h4) .+ cos.(sqrt(2).*t_h4))
ε_h4 = 0.1 * (maximum(x_h4) - minimum(x_h4))   
evaluate_system("KLASSE 2: QUASIPERIODIC", x_h4, ε_h4, M_default; run_norb=true)

# 2e) Resonanz (dim = 2) -> Norbert überspringen
t_h5 = range(0, step=0.1*pi, length=N_points)
x_h5 = hcat(sin.(t_h5), cos.(t_h5))
ε_h5 = 0.1 * (maximum(x_h5) - minimum(x_h5))   
evaluate_system("KLASSE 2: PERIODIC (RESONANZ)", x_h5, ε_h5, M_default; run_norb=false)

# ---------------------------------------------------------
# KLASSE 3: WHITE NOISE (dim = 1)
# ---------------------------------------------------------
Random.seed!(123) 
x_noise = reshape(randn(N_points), :, 1)
ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   
evaluate_system("KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise, M_default; run_norb=true)

# ---------------------------------------------------------
# KLASSE 4: DRIFT / RANDOM WALK (dim = 1)
# ---------------------------------------------------------
Random.seed!(123) 
x_drift = reshape(cumsum(randn(N_points)), :, 1)
ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   
evaluate_system("KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift, M_default; run_norb=true)