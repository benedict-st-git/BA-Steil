using BenchmarkTools
using Random
using Statistics
using DifferentialEquations
using DelayEmbeddings
using Sobol
include("../Norberts_RQA_Code/RPLineLengths.jl")
include("my_sampling.jl")

# ====================================================================
# Zentrale Evaluierungs-Funktion (Wissenschaftliche Best Practice)
# ====================================================================
function evaluate_system(system_name::String, x::AbstractMatrix, ε::Float64, M::Int)
    println("\n\n" * "="^70)
    println(" SYSTEM: $system_name")
    println("="^70)
    
    N_val = size(x, 1)
    total_pairs = round(Int, N_val * (N_val - 1) / 2)

    # --- 1. Baseline (woRP) dynamisch berechnen ---
    histL_woRP = get_hist_diagonal_woRP(x, ε)
    rqa_woRP = rqa(histL_woRP, total_pairs)
    b_woRP = @benchmark get_hist_diagonal_woRP($x, $ε)

    println("\n=== PERFORMANCE - woRP (BASELINE) ===")
    println("runtime:     ", round(median(b_woRP.times) / 1e6, digits=2), " ms")
    println("allocations: ", b_woRP.allocs)
    println("storage:     ", round(b_woRP.memory / 1024, digits=2), " KiB")
    println("RR:   ", rqa_woRP[1])
    println("DET:  ", rqa_woRP[2])
    println("L:    ", rqa_woRP[3])
    println("ENTR: ", rqa_woRP[4])

    # --- 2. Benchmarking W/O Seed  ---
    b_norb = @benchmark get_hist_diagonal_sampled($x, $ε, $M)
    b_imp  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M)
    b_ep   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M)
    b_lfb  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M)
    b_hyb_lfb = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M)
    b_hyb_fwd = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_forward_condition($x, $ε, $M)

    # --- 3. Benchmarking WITH Seed ---
    b_norb_seed = @benchmark get_hist_diagonal_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_imp_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_ep_seed   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_lfb_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb_lfb_seed = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb_fwd_seed = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_forward_condition($x, $ε, $M) setup=(Random.seed!(42)) evals=1

    # --- 4. Seed Runs ---
    Random.seed!(42); histL_seed_norb, cnt_seed_norb = get_hist_diagonal_sampled(x, ε, M)
    Random.seed!(42); histL_seed_imp, cnt_seed_imp = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
    Random.seed!(42); histL_seed_ep, cnt_seed_ep = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
    Random.seed!(42); histL_seed_lfb, cnt_seed_lfb = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
    Random.seed!(42); histL_seed_hyb_lfb, cnt_seed_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
    Random.seed!(42); histL_seed_hyb_fwd, cnt_seed_hyb_fwd = smi_LFboth_or_norbert_rand_with_LineLength_forward_condition(x, ε, M)

    rqa_seed_norb = rqa(histL_seed_norb, cnt_seed_norb)
    rqa_seed_imp  = rqa(histL_seed_imp, cnt_seed_imp)
    rqa_seed_ep   = rqa(histL_seed_ep, cnt_seed_ep)
    rqa_seed_lfb  = rqa(histL_seed_lfb, cnt_seed_lfb)
    rqa_seed_hyb_lfb = rqa(histL_seed_hyb_lfb, cnt_seed_hyb_lfb)
    rqa_seed_hyb_fwd = rqa(histL_seed_hyb_fwd, cnt_seed_hyb_fwd)

    # --- 5. Statistical Runs (1000 Iterationen) ---
    RR_norb_stat = zeros(1000); DET_norb_stat = zeros(1000); L_norb_stat = zeros(1000); ENTR_norb_stat = zeros(1000); count_norb = zeros(Int, 1000)
    RR_imp_stat  = zeros(1000); DET_imp_stat  = zeros(1000); L_imp_stat  = zeros(1000); ENTR_imp_stat  = zeros(1000); count_imp  = zeros(Int, 1000)
    RR_ep_stat   = zeros(1000); DET_ep_stat   = zeros(1000); L_ep_stat   = zeros(1000); ENTR_ep_stat   = zeros(1000); count_ep   = zeros(Int, 1000)
    RR_lfb_stat  = zeros(1000); DET_lfb_stat  = zeros(1000); L_lfb_stat  = zeros(1000); ENTR_lfb_stat  = zeros(1000); count_lfb  = zeros(Int, 1000)
    RR_hyb_lfb_stat = zeros(1000); DET_hyb_lfb_stat = zeros(1000); L_hyb_lfb_stat = zeros(1000); ENTR_hyb_lfb_stat = zeros(1000); count_hyb_lfb = zeros(Int, 1000)
    RR_hyb_fwd_stat = zeros(1000); DET_hyb_fwd_stat = zeros(1000); L_hyb_fwd_stat = zeros(1000); ENTR_hyb_fwd_stat = zeros(1000); count_hyb_fwd = zeros(Int, 1000)

    for n in 1:1000
        h_norb, c_norb = get_hist_diagonal_sampled(x, ε, M)
        h_imp, c_imp   = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
        h_ep, c_ep     = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
        h_lfb, c_lfb   = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
        h_hyb_lfb, c_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
        h_hyb_fwd, c_hyb_fwd = smi_LFboth_or_norbert_rand_with_LineLength_forward_condition(x, ε, M)

        count_norb[n] = c_norb; count_imp[n] = c_imp; count_ep[n] = c_ep; count_lfb[n] = c_lfb
        count_hyb_lfb[n] = c_hyb_lfb; count_hyb_fwd[n] = c_hyb_fwd

        rqa_norb = rqa(h_norb, c_norb); rqa_imp = rqa(h_imp, c_imp); rqa_ep = rqa(h_ep, c_ep); rqa_lfb = rqa(h_lfb, c_lfb)
        rqa_hyb_lfb = rqa(h_hyb_lfb, c_hyb_lfb); rqa_hyb_fwd = rqa(h_hyb_fwd, c_hyb_fwd)
        
        RR_norb_stat[n] = rqa_norb[1]; DET_norb_stat[n] = rqa_norb[2]; L_norb_stat[n] = rqa_norb[3]; ENTR_norb_stat[n] = rqa_norb[4]
        RR_imp_stat[n]  = rqa_imp[1];  DET_imp_stat[n]  = rqa_imp[2];  L_imp_stat[n]  = rqa_imp[3];  ENTR_imp_stat[n]  = rqa_imp[4]
        RR_ep_stat[n]   = rqa_ep[1];   DET_ep_stat[n]   = rqa_ep[2];   L_ep_stat[n]   = rqa_ep[3];   ENTR_ep_stat[n]   = rqa_ep[4]
        RR_lfb_stat[n]  = rqa_lfb[1];  DET_lfb_stat[n]  = rqa_lfb[2];  L_lfb_stat[n]  = rqa_lfb[3];  ENTR_lfb_stat[n]  = rqa_lfb[4]
        RR_hyb_lfb_stat[n] = rqa_hyb_lfb[1]; DET_hyb_lfb_stat[n] = rqa_hyb_lfb[2]; L_hyb_lfb_stat[n] = rqa_hyb_lfb[3]; ENTR_hyb_lfb_stat[n] = rqa_hyb_lfb[4]
        RR_hyb_fwd_stat[n] = rqa_hyb_fwd[1]; DET_hyb_fwd_stat[n] = rqa_hyb_fwd[2]; L_hyb_fwd_stat[n] = rqa_hyb_fwd[3]; ENTR_hyb_fwd_stat[n] = rqa_hyb_fwd[4]
    end

    # --- 6. Formatierte Ausgaben ---
    methods = [
        ("Norberts Sampling", b_norb, b_norb_seed, rqa_seed_norb, cnt_seed_norb, count_norb, RR_norb_stat, DET_norb_stat, L_norb_stat, ENTR_norb_stat),
        ("Importance Stratified Memory", b_imp, b_imp_seed, rqa_seed_imp, cnt_seed_imp, count_imp, RR_imp_stat, DET_imp_stat, L_imp_stat, ENTR_imp_stat),
        ("Importance Stratified Memory EP", b_ep, b_ep_seed, rqa_seed_ep, cnt_seed_ep, count_ep, RR_ep_stat, DET_ep_stat, L_ep_stat, ENTR_ep_stat),
        ("Importance Stratified Memory LFBOTH", b_lfb, b_lfb_seed, rqa_seed_lfb, cnt_seed_lfb, count_lfb, RR_lfb_stat, DET_lfb_stat, L_lfb_stat, ENTR_lfb_stat),
        ("Hybrid (LFboth Condition)", b_hyb_lfb, b_hyb_lfb_seed, rqa_seed_hyb_lfb, cnt_seed_hyb_lfb, count_hyb_lfb, RR_hyb_lfb_stat, DET_hyb_lfb_stat, L_hyb_lfb_stat, ENTR_hyb_lfb_stat),
        ("Hybrid (Forward Condition)", b_hyb_fwd, b_hyb_fwd_seed, rqa_seed_hyb_fwd, cnt_seed_hyb_fwd, count_hyb_fwd, RR_hyb_fwd_stat, DET_hyb_fwd_stat, L_hyb_fwd_stat, ENTR_hyb_fwd_stat)
    ]

    for (name, b, b_seed, r_seed, c_seed, c_stat, rr_stat, det_stat, l_stat, entr_stat) in methods
        println("\n=== PERFORMANCE - $name ===")
        
        # Benchmark w/o Seed
        println("\n  [Benchmark W/O Seed]")
        println("runtime:     ", round(median(b.times) / 1e6, digits=2), " ms")
        println("allocations: ", b.allocs)
        println("storage:     ", round(b.memory / 1024, digits=2), " KiB")

        # Benchmark with Seed
        println("\n  [Benchmark WITH Seed (Random.seed!(42))]")
        println("runtime:     ", round(median(b_seed.times) / 1e6, digits=2), " ms")
        println("allocations: ", b_seed.allocs)
        println("storage:     ", round(b_seed.memory / 1024, digits=2), " KiB")
        
        # Statistische Auswertung
        println("\n  [Statistisch W/O Seed (1000 Läufe)]")
        println("  countAll: ", round(mean(c_stat), digits=2), " ± ", round(std(c_stat), digits=2))
        println("  RR:       ", mean(rr_stat), " ± ", std(rr_stat))
        println("    -> ΔwoRP: ", mean(rr_stat) - rqa_woRP[1], " ± ", std(rr_stat))
        println("  DET:      ", mean(det_stat), " ± ", std(det_stat))
        println("    -> ΔwoRP: ", mean(det_stat) - rqa_woRP[2], " ± ", std(det_stat))
        println("  L:        ", mean(l_stat), " ± ", std(l_stat))
        println("    -> ΔwoRP: ", mean(l_stat) - rqa_woRP[3], " ± ", std(l_stat))
        println("  ENTR:     ", mean(entr_stat), " ± ", std(entr_stat))
        println("    -> ΔwoRP: ", mean(entr_stat) - rqa_woRP[4], " ± ", std(entr_stat))

        # Seed Auswertung
        println("\n  [Exakt WITH Seed (Random.seed!(42))]")
        println("  countAll: ", c_seed)
        println("  RR:       ", r_seed[1], " (ΔwoRP: ", r_seed[1] - rqa_woRP[1], ")")
        println("  DET:      ", r_seed[2], " (ΔwoRP: ", r_seed[2] - rqa_woRP[2], ")")
        println("  L:        ", r_seed[3], " (ΔwoRP: ", r_seed[3] - rqa_woRP[3], ")")
        println("  ENTR:     ", r_seed[4], " (ΔwoRP: ", r_seed[4] - rqa_woRP[4], ")")
    end
end


# ====================================================================
# Datengenerierung & Ausführung
# ====================================================================
N_points = 10000

# ---------------------------------------------------------
# KLASSE 1: CHAOS (ROESSLER SYSTEM)
# ---------------------------------------------------------
function roessler!(du, u, p, t)
    du[1] = -u[2] - u[3]
    du[2] = u[1] + 0.2 * u[2]
    du[3] = 0.2 + u[3] * (u[1] - 5.7)
end

prob_r = ODEProblem(roessler!, [-6.2668, -1.3413, 0.0166], (0.0, (N_points + 100 - 1) * 0.2)) 
sol_r = solve(prob_r, Tsit5(), saveat=0.2) 
x_c1 = transpose(hcat(sol_r.u...))[101:end, :]               

ε_c1 = 0.1 * (maximum(x_c1) - minimum(x_c1))   
M_c1 = Int(round(0.2 * N_points))

evaluate_system("KLASSE 1: CHAOS (ROESSLER SYSTEM)", x_c1, ε_c1, M_c1)

# ---------------------------------------------------------
# KLASSE 1: CHAOS (LORENZ SYSTEM)
# ---------------------------------------------------------
function generate_lorenz(N; dt=0.01, σ=10.0, ρ=28.0, β=8/3)
    x = zeros(Float64, N, 3)
    x[1, :] .= [1.0, 1.0, 1.0] # Initiale Startwerte
    
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
M_lorenz = Int(round(0.2 * N_points))

evaluate_system("KLASSE 1: CHAOS (LORENZ SYSTEM)", x_lorenz, ε_lorenz, M_lorenz)


# ---------------------------------------------------------
# KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
# ---------------------------------------------------------
t_harm_osc = range(0, step=0.1, length=N_points)
x_harm_osc = reshape(sin.(t_harm_osc), :, 1)

ε_harm_osc = 0.1 * (maximum(x_harm_osc) - minimum(x_harm_osc))   
M_harm_osc = Int(round(0.2 * N_points))

evaluate_system("KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc, ε_harm_osc, M_harm_osc)


# ---------------------------------------------------------
# KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbares Rauschen
x_noise = reshape(randn(N_points), :, 1)

ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   
M_noise = Int(round(0.2 * N_points))

evaluate_system("KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise, M_noise)


# ---------------------------------------------------------
# KLASSE 4: DRIFT (RANDOM WALK)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbarer Random Walk
x_drift = reshape(cumsum(randn(N_points)), :, 1)

ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   
M_drift = Int(round(0.2 * N_points))

evaluate_system("KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift, M_drift)