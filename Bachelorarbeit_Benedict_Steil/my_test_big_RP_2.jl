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
    #b_imp  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M)
    #b_ep   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M)
    b_lfb  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M)
    #b_hyb_lfb = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M)
    b_hyb1_dep_womf = @benchmark hybrid1_dep_womf($x, $ε, $M)
    b_hyb1_dep = @benchmark hybrid1_dep($x, $ε, $M)
    b_hyb1_dep_womf_wnlfb = @benchmark hybrid1_dep_womf_wnlfb($x, $ε, $M)

    #b_hyb1_fft_womf = @benchmark hybrid1_fft_womf($x, $ε, $M)
    #b_hyb1_fft = @benchmark hybrid1_fft($x, $ε, $M)
    #b_hyb1_xx_womf = @benchmark hybrid1_xx_womf($x, $ε, $M)
    #b_hyb1_xx = @benchmark hybrid1_xx($x, $ε, $M)
    #b_hyb1_abs_womf = @benchmark hybrid1_abs_womf($x, $ε, $M)
    #b_hyb1_abs = @benchmark hybrid1_abs($x, $ε, $M)

    # --- 3. Benchmarking WITH Seed ---
    b_norb_seed = @benchmark get_hist_diagonal_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_imp_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_ep_seed   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_lfb_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb_lfb_seed = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb1_dep_womf_seed = @benchmark hybrid1_dep_womf($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb1_dep_seed = @benchmark hybrid1_dep($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb1_dep_womf_wnlfb_seed = @benchmark hybrid1_dep_womf_wnlfb($x, $ε, $M) setup=(Random.seed!(42)) evals=1

    #b_hyb1_fft_womf_seed = @benchmark hybrid1_fft_womf($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_fft_seed = @benchmark hybrid1_fft($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_xx_womf_seed = @benchmark hybrid1_xx_womf($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_xx_seed = @benchmark hybrid1_xx($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_abs_womf_seed = @benchmark hybrid1_abs_womf($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_abs_seed = @benchmark hybrid1_abs($x, $ε, $M) setup=(Random.seed!(42)) evals=1

    # --- 4. Seed Runs ---
    Random.seed!(42); histL_seed_norb, cnt_seed_norb = get_hist_diagonal_sampled(x, ε, M)
    #Random.seed!(42); histL_seed_imp, cnt_seed_imp = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
    #Random.seed!(42); histL_seed_ep, cnt_seed_ep = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
    Random.seed!(42); histL_seed_lfb, cnt_seed_lfb = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
    #Random.seed!(42); histL_seed_hyb_lfb, cnt_seed_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
    Random.seed!(42); histL_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf = hybrid1_dep_womf(x, ε, M)
    Random.seed!(42); histL_seed_hyb1_dep, cnt_seed_hyb1_dep = hybrid1_dep(x, ε, M)
    Random.seed!(42); histL_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb = hybrid1_dep_womf_wnlfb(x, ε, M)

    #Random.seed!(42); histL_seed_hyb1_fft_womf, cnt_seed_hyb1_fft_womf = hybrid1_fft_womf(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_fft, cnt_seed_hyb1_fft = hybrid1_fft(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_xx_womf, cnt_seed_hyb1_xx_womf = hybrid1_xx_womf(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_xx, cnt_seed_hyb1_xx = hybrid1_xx(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_abs_womf, cnt_seed_hyb1_abs_womf = hybrid1_abs_womf(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_abs, cnt_seed_hyb1_abs = hybrid1_abs(x, ε, M)

    rqa_seed_norb = rqa(histL_seed_norb, cnt_seed_norb)
    #rqa_seed_imp  = rqa(histL_seed_imp, cnt_seed_imp)
    #rqa_seed_ep   = rqa(histL_seed_ep, cnt_seed_ep)
    rqa_seed_lfb  = rqa(histL_seed_lfb, cnt_seed_lfb)
    #rqa_seed_hyb_lfb = rqa(histL_seed_hyb_lfb, cnt_seed_hyb_lfb)
    rqa_seed_hyb1_dep_womf = rqa(histL_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf)
    rqa_seed_hyb1_dep = rqa(histL_seed_hyb1_dep, cnt_seed_hyb1_dep)
    rqa_seed_hyb1_dep_womf_wnlfb = rqa(histL_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb)

    #rqa_seed_hyb1_fft_womf = rqa(histL_seed_hyb1_fft_womf, cnt_seed_hyb1_fft_womf)
    #rqa_seed_hyb1_fft = rqa(histL_seed_hyb1_fft, cnt_seed_hyb1_fft)
    #rqa_seed_hyb1_xx_womf = rqa(histL_seed_hyb1_xx_womf, cnt_seed_hyb1_xx_womf)
    #rqa_seed_hyb1_xx = rqa(histL_seed_hyb1_xx, cnt_seed_hyb1_xx)
    #rqa_seed_hyb1_abs_womf = rqa(histL_seed_hyb1_abs_womf, cnt_seed_hyb1_abs_womf)
    #rqa_seed_hyb1_abs = rqa(histL_seed_hyb1_abs, cnt_seed_hyb1_abs)

    # --- 5. Statistical Runs (1000 Iterationen) ---
    RR_norb_stat = zeros(1000); DET_norb_stat = zeros(1000); L_norb_stat = zeros(1000); ENTR_norb_stat = zeros(1000); count_norb = zeros(Int, 1000)
    # RR_imp_stat  = zeros(1000); DET_imp_stat  = zeros(1000); L_imp_stat  = zeros(1000); ENTR_imp_stat  = zeros(1000); count_imp  = zeros(Int, 1000)
    # RR_ep_stat   = zeros(1000); DET_ep_stat   = zeros(1000); L_ep_stat   = zeros(1000); ENTR_ep_stat   = zeros(1000); count_ep   = zeros(Int, 1000)
    RR_lfb_stat  = zeros(1000); DET_lfb_stat  = zeros(1000); L_lfb_stat  = zeros(1000); ENTR_lfb_stat  = zeros(1000); count_lfb  = zeros(Int, 1000)
    # RR_hyb_lfb_stat = zeros(1000); DET_hyb_lfb_stat = zeros(1000); L_hyb_lfb_stat = zeros(1000); ENTR_hyb_lfb_stat = zeros(1000); count_hyb_lfb = zeros(Int, 1000)
    RR_hyb1_dep_womf_stat = zeros(1000); DET_hyb1_dep_womf_stat = zeros(1000); L_hyb1_dep_womf_stat = zeros(1000); ENTR_hyb1_dep_womf_stat = zeros(1000); count_hyb1_dep_womf = zeros(Int, 1000)
    RR_hyb1_dep_stat = zeros(1000); DET_hyb1_dep_stat = zeros(1000); L_hyb1_dep_stat = zeros(1000); ENTR_hyb1_dep_stat = zeros(1000); count_hyb1_dep_stat = zeros(Int, 1000)
    RR_hyb1_dep_womf_wnlfb_stat = zeros(1000); DET_hyb1_dep_womf_wnlfb_stat = zeros(1000); L_hyb1_dep_womf_wnlfb_stat = zeros(1000); ENTR_hyb1_dep_womf_wnlfb_stat = zeros(1000); count_hyb1_dep_womf_wnlfb = zeros(Int, 1000)

    #RR_hyb1_fft_womf_stat = zeros(1000); DET_hyb1_fft_womf_stat = zeros(1000); L_hyb1_fft_womf_stat = zeros(1000); ENTR_hyb1_fft_womf_stat = zeros(1000); count_hyb1_fft_womf = zeros(Int, 1000)
    #RR_hyb1_fft_stat = zeros(1000); DET_hyb1_fft_stat = zeros(1000); L_hyb1_fft_stat = zeros(1000); ENTR_hyb1_fft_stat = zeros(1000); count_hyb1_fft = zeros(Int, 1000)
    #RR_hyb1_xx_womf_stat = zeros(1000); DET_hyb1_xx_womf_stat = zeros(1000); L_hyb1_xx_womf_stat = zeros(1000); ENTR_hyb1_xx_womf_stat = zeros(1000); count_hyb1_xx_womf = zeros(Int, 1000)
    #RR_hyb1_xx_stat = zeros(1000); DET_hyb1_xx_stat = zeros(1000); L_hyb1_xx_stat = zeros(1000); ENTR_hyb1_xx_stat = zeros(1000); count_hyb1_xx = zeros(Int, 1000)
    #RR_hyb1_abs_womf_stat = zeros(1000); DET_hyb1_abs_womf_stat = zeros(1000); L_hyb1_abs_womf_stat = zeros(1000); ENTR_hyb1_abs_womf_stat = zeros(1000); count_hyb1_abs_womf = zeros(Int, 1000)
    #RR_hyb1_abs_stat = zeros(1000); DET_hyb1_abs_stat = zeros(1000); L_hyb1_abs_stat = zeros(1000); ENTR_hyb1_abs_stat = zeros(1000); count_hyb1_abs = zeros(Int, 1000)

    for n in 1:1000
        h_norb, c_norb = get_hist_diagonal_sampled(x, ε, M)
        #h_imp, c_imp   = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
        #h_ep, c_ep     = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
        h_lfb, c_lfb   = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
        #h_hyb_lfb, c_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
        h_hyb1_dep_womf, c_hyb1_dep_womf = hybrid1_dep_womf(x, ε, M)
        h_hyb1_dep, c_hyb1_dep = hybrid1_dep(x, ε, M)
        h_hyb1_dep_womf_wnlfb, c_hyb1_dep_womf_wnlfb = hybrid1_dep_womf_wnlfb(x, ε, M)

        #h_hyb1_fft_womf, c_hyb1_fft_womf = hybrid1_fft_womf(x, ε, M)
        #h_hyb1_fft, c_hyb1_fft = hybrid1_fft(x, ε, M)
        #h_hyb1_xx_womf, c_hyb1_xx_womf = hybrid1_xx_womf(x, ε, M)
        #h_hyb1_xx, c_hyb1_xx = hybrid1_xx(x, ε, M)
        #h_hyb1_abs_womf, c_hyb1_abs_womf = hybrid1_abs_womf(x, ε, M)
        #h_hyb1_abs, c_hyb1_abs = hybrid1_abs(x, ε, M)

        count_norb[n] = c_norb;  count_lfb[n] = c_lfb; count_hyb1_dep_womf[n] = c_hyb1_dep_womf; count_hyb1_dep_stat[n] = c_hyb1_dep; count_hyb1_dep_womf_wnlfb[n] = c_hyb1_dep_womf_wnlfb
        #count_hyb_lfb[n] = c_hyb_lfb; count_imp[n] = c_imp; count_ep[n] = c_ep
        
        #count_hyb1_fft_womf[n] = c_hyb1_fft_womf; count_hyb1_fft[n] = c_hyb1_fft
        #count_hyb1_xx_womf[n] = c_hyb1_xx_womf; count_hyb1_xx[n] = c_hyb1_xx
        #count_hyb1_abs_womf[n] = c_hyb1_abs_womf; count_hyb1_abs[n] = c_hyb1_abs

        rqa_norb = rqa(h_norb, c_norb);  rqa_lfb = rqa(h_lfb, c_lfb); rqa_hyb1_dep_womf = rqa(h_hyb1_dep_womf, c_hyb1_dep_womf); rqa_hyb1_dep = rqa(h_hyb1_dep, c_hyb1_dep); rqa_hyb1_dep_womf_wnlfb = rqa(h_hyb1_dep_womf_wnlfb, c_hyb1_dep_womf_wnlfb)
        #rqa_imp = rqa(h_imp, c_imp); rqa_ep = rqa(h_ep, c_ep); rqa_hyb_lfb = rqa(h_hyb_lfb, c_hyb_lfb) 
        
        #rqa_hyb1_fft_womf = rqa(h_hyb1_fft_womf, c_hyb1_fft_womf); rqa_hyb1_fft = rqa(h_hyb1_fft, c_hyb1_fft)
        #rqa_hyb1_xx_womf = rqa(h_hyb1_xx_womf, c_hyb1_xx_womf); rqa_hyb1_xx = rqa(h_hyb1_xx, c_hyb1_xx)
        #rqa_hyb1_abs_womf = rqa(h_hyb1_abs_womf, c_hyb1_abs_womf); rqa_hyb1_abs = rqa(h_hyb1_abs, c_hyb1_abs)
        
        RR_norb_stat[n] = rqa_norb[1]; DET_norb_stat[n] = rqa_norb[2]; L_norb_stat[n] = rqa_norb[3]; ENTR_norb_stat[n] = rqa_norb[4]
        #RR_imp_stat[n]  = rqa_imp[1];  DET_imp_stat[n]  = rqa_imp[2];  L_imp_stat[n]  = rqa_imp[3];  ENTR_imp_stat[n]  = rqa_imp[4]
        #RR_ep_stat[n]   = rqa_ep[1];   DET_ep_stat[n]   = rqa_ep[2];   L_ep_stat[n]   = rqa_ep[3];   ENTR_ep_stat[n]   = rqa_ep[4]
        RR_lfb_stat[n]  = rqa_lfb[1];  DET_lfb_stat[n]  = rqa_lfb[2];  L_lfb_stat[n]  = rqa_lfb[3];  ENTR_lfb_stat[n]  = rqa_lfb[4]
        #RR_hyb_lfb_stat[n] = rqa_hyb_lfb[1]; DET_hyb_lfb_stat[n] = rqa_hyb_lfb[2]; L_hyb_lfb_stat[n] = rqa_hyb_lfb[3]; ENTR_hyb_lfb_stat[n] = rqa_hyb_lfb[4]
        RR_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[1]; DET_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[2]; L_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[3]; ENTR_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[4]
        RR_hyb1_dep_stat[n] = rqa_hyb1_dep[1]; DET_hyb1_dep_stat[n] = rqa_hyb1_dep[2]; L_hyb1_dep_stat[n] = rqa_hyb1_dep[3]; ENTR_hyb1_dep_stat[n] = rqa_hyb1_dep[4]
        RR_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[1]; DET_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[2]; L_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[3]; ENTR_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[4]
        
        #RR_hyb1_fft_womf_stat[n] = rqa_hyb1_fft_womf[1]; DET_hyb1_fft_womf_stat[n] = rqa_hyb1_fft_womf[2]; L_hyb1_fft_womf_stat[n] = rqa_hyb1_fft_womf[3]; ENTR_hyb1_fft_womf_stat[n] = rqa_hyb1_fft_womf[4]
        #RR_hyb1_fft_stat[n] = rqa_hyb1_fft[1]; DET_hyb1_fft_stat[n] = rqa_hyb1_fft[2]; L_hyb1_fft_stat[n] = rqa_hyb1_fft[3]; ENTR_hyb1_fft_stat[n] = rqa_hyb1_fft[4]
        #RR_hyb1_xx_womf_stat[n] = rqa_hyb1_xx_womf[1]; DET_hyb1_xx_womf_stat[n] = rqa_hyb1_xx_womf[2]; L_hyb1_xx_womf_stat[n] = rqa_hyb1_xx_womf[3]; ENTR_hyb1_xx_womf_stat[n] = rqa_hyb1_xx_womf[4]
        #RR_hyb1_xx_stat[n] = rqa_hyb1_xx[1]; DET_hyb1_xx_stat[n] = rqa_hyb1_xx[2]; L_hyb1_xx_stat[n] = rqa_hyb1_xx[3]; ENTR_hyb1_xx_stat[n] = rqa_hyb1_xx[4]
        #RR_hyb1_abs_womf_stat[n] = rqa_hyb1_abs_womf[1]; DET_hyb1_abs_womf_stat[n] = rqa_hyb1_abs_womf[2]; L_hyb1_abs_womf_stat[n] = rqa_hyb1_abs_womf[3]; ENTR_hyb1_abs_womf_stat[n] = rqa_hyb1_abs_womf[4]
        #RR_hyb1_abs_stat[n] = rqa_hyb1_abs[1]; DET_hyb1_abs_stat[n] = rqa_hyb1_abs[2]; L_hyb1_abs_stat[n] = rqa_hyb1_abs[3]; ENTR_hyb1_abs_stat[n] = rqa_hyb1_abs[4]
    end

    # --- 6. Formatierte Ausgaben ---
    methods = [
        ("Norberts Sampling", b_norb, b_norb_seed, rqa_seed_norb, cnt_seed_norb, count_norb, RR_norb_stat, DET_norb_stat, L_norb_stat, ENTR_norb_stat),
        #("Importance Stratified Memory", b_imp, b_imp_seed, rqa_seed_imp, cnt_seed_imp, count_imp, RR_imp_stat, DET_imp_stat, L_imp_stat, ENTR_imp_stat),
        #("Importance Stratified Memory EP", b_ep, b_ep_seed, rqa_seed_ep, cnt_seed_ep, count_ep, RR_ep_stat, DET_ep_stat, L_ep_stat, ENTR_ep_stat),
        ("Importance Stratified Memory LFBOTH", b_lfb, b_lfb_seed, rqa_seed_lfb, cnt_seed_lfb, count_lfb, RR_lfb_stat, DET_lfb_stat, L_lfb_stat, ENTR_lfb_stat),
        #("Hybrid (LFboth Condition)", b_hyb_lfb, b_hyb_lfb_seed, rqa_seed_hyb_lfb, cnt_seed_hyb_lfb, count_hyb_lfb, RR_hyb_lfb_stat, DET_hyb_lfb_stat, L_hyb_lfb_stat, ENTR_hyb_lfb_stat),
        ("Hybrid1 (dep + womf)", b_hyb1_dep_womf, b_hyb1_dep_womf_seed, rqa_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf, count_hyb1_dep_womf, RR_hyb1_dep_womf_stat, DET_hyb1_dep_womf_stat, L_hyb1_dep_womf_stat, ENTR_hyb1_dep_womf_stat),
        ("Hybrid1 (dep)", b_hyb1_dep, b_hyb1_dep_seed, rqa_seed_hyb1_dep, cnt_seed_hyb1_dep, count_hyb1_dep_stat, RR_hyb1_dep_stat, DET_hyb1_dep_stat, L_hyb1_dep_stat, ENTR_hyb1_dep_stat),
        ("Hybrid1 (dep + womf + wnlfb)", b_hyb1_dep_womf_wnlfb, b_hyb1_dep_womf_wnlfb_seed, rqa_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb, count_hyb1_dep_womf_wnlfb, RR_hyb1_dep_womf_wnlfb_stat, DET_hyb1_dep_womf_wnlfb_stat, L_hyb1_dep_womf_wnlfb_stat, ENTR_hyb1_dep_womf_wnlfb_stat)
        
        #("Hybrid1 (fft + womf)", b_hyb1_fft_womf, b_hyb1_fft_womf_seed, rqa_seed_hyb1_fft_womf, cnt_seed_hyb1_fft_womf, count_hyb1_fft_womf, RR_hyb1_fft_womf_stat, DET_hyb1_fft_womf_stat, L_hyb1_fft_womf_stat, ENTR_hyb1_fft_womf_stat),
        #("Hybrid1 (fft)", b_hyb1_fft, b_hyb1_fft_seed, rqa_seed_hyb1_fft, cnt_seed_hyb1_fft, count_hyb1_fft, RR_hyb1_fft_stat, DET_hyb1_fft_stat, L_hyb1_fft_stat, ENTR_hyb1_fft_stat),
        #("Hybrid1 (xx + womf)", b_hyb1_xx_womf, b_hyb1_xx_womf_seed, rqa_seed_hyb1_xx_womf, cnt_seed_hyb1_xx_womf, count_hyb1_xx_womf, RR_hyb1_xx_womf_stat, DET_hyb1_xx_womf_stat, L_hyb1_xx_womf_stat, ENTR_hyb1_xx_womf_stat),
        #("Hybrid1 (xx)", b_hyb1_xx, b_hyb1_xx_seed, rqa_seed_hyb1_xx, cnt_seed_hyb1_xx, count_hyb1_xx, RR_hyb1_xx_stat, DET_hyb1_xx_stat, L_hyb1_xx_stat, ENTR_hyb1_xx_stat),
        #("Hybrid1 (abs + womf)", b_hyb1_abs_womf, b_hyb1_abs_womf_seed, rqa_seed_hyb1_abs_womf, cnt_seed_hyb1_abs_womf, count_hyb1_abs_womf, RR_hyb1_abs_womf_stat, DET_hyb1_abs_womf_stat, L_hyb1_abs_womf_stat, ENTR_hyb1_abs_womf_stat),
        #("Hybrid1 (abs)", b_hyb1_abs, b_hyb1_abs_seed, rqa_seed_hyb1_abs, cnt_seed_hyb1_abs, count_hyb1_abs, RR_hyb1_abs_stat, DET_hyb1_abs_stat, L_hyb1_abs_stat, ENTR_hyb1_abs_stat)
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
# Evaluierungs-Funktion WONOB (Without Norberts Random Sampling)
# ====================================================================
function evaluate_system_wonob(system_name::String, x::AbstractMatrix, ε::Float64, M::Int)
    println("\n\n" * "="^70)
    println(" SYSTEM (WONOB): $system_name")
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
    #b_norb = @benchmark get_hist_diagonal_sampled($x, $ε, $M)
    #b_imp  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M)
    #b_ep   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M)
    b_lfb  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M)
    #b_hyb_lfb = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M)
    #b_hyb1_dep_womf = @benchmark hybrid1_dep_womf($x, $ε, $M)
    #b_hyb1_dep = @benchmark hybrid1_dep($x, $ε, $M)
    b_hyb1_dep_womf_wnlfb = @benchmark hybrid1_dep_womf_wnlfb($x, $ε, $M)

    # --- 3. Benchmarking WITH Seed ---
    #b_norb_seed = @benchmark get_hist_diagonal_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_imp_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_ep_seed   = @benchmark get_hist_diagonal_importance_stratified_memory_sampledEP($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_lfb_seed  = @benchmark get_hist_diagonal_importance_stratified_memory_sampled_LFboth($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb_lfb_seed = @benchmark smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_dep_womf_seed = @benchmark hybrid1_dep_womf($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    #b_hyb1_dep_seed = @benchmark hybrid1_dep($x, $ε, $M) setup=(Random.seed!(42)) evals=1
    b_hyb1_dep_womf_wnlfb_seed = @benchmark hybrid1_dep_womf_wnlfb($x, $ε, $M) setup=(Random.seed!(42)) evals=1

    # --- 4. Seed Runs ---
    #Random.seed!(42); histL_seed_norb, cnt_seed_norb = get_hist_diagonal_sampled(x, ε, M)
    #Random.seed!(42); histL_seed_imp, cnt_seed_imp = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
    #Random.seed!(42); histL_seed_ep, cnt_seed_ep = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
    Random.seed!(42); histL_seed_lfb, cnt_seed_lfb = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
    #Random.seed!(42); histL_seed_hyb_lfb, cnt_seed_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf = hybrid1_dep_womf(x, ε, M)
    #Random.seed!(42); histL_seed_hyb1_dep, cnt_seed_hyb1_dep = hybrid1_dep(x, ε, M)
    Random.seed!(42); histL_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb = hybrid1_dep_womf_wnlfb(x, ε, M)

    #rqa_seed_norb = rqa(histL_seed_norb, cnt_seed_norb)
    #rqa_seed_imp  = rqa(histL_seed_imp, cnt_seed_imp)
    #rqa_seed_ep   = rqa(histL_seed_ep, cnt_seed_ep)
    rqa_seed_lfb  = rqa(histL_seed_lfb, cnt_seed_lfb)
    #rqa_seed_hyb_lfb = rqa(histL_seed_hyb_lfb, cnt_seed_hyb_lfb)
    #rqa_seed_hyb1_dep_womf = rqa(histL_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf)
    #rqa_seed_hyb1_dep = rqa(histL_seed_hyb1_dep, cnt_seed_hyb1_dep)
    rqa_seed_hyb1_dep_womf_wnlfb = rqa(histL_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb)

    # --- 5. Statistical Runs (1000 Iterationen) ---
    #RR_norb_stat = zeros(1000); DET_norb_stat = zeros(1000); L_norb_stat = zeros(1000); ENTR_norb_stat = zeros(1000); count_norb = zeros(Int, 1000)
    # RR_imp_stat  = zeros(1000); DET_imp_stat  = zeros(1000); L_imp_stat  = zeros(1000); ENTR_imp_stat  = zeros(1000); count_imp  = zeros(Int, 1000)
    # RR_ep_stat   = zeros(1000); DET_ep_stat   = zeros(1000); L_ep_stat   = zeros(1000); ENTR_ep_stat   = zeros(1000); count_ep   = zeros(Int, 1000)
    RR_lfb_stat  = zeros(1000); DET_lfb_stat  = zeros(1000); L_lfb_stat  = zeros(1000); ENTR_lfb_stat  = zeros(1000); count_lfb  = zeros(Int, 1000)
    # RR_hyb_lfb_stat = zeros(1000); DET_hyb_lfb_stat = zeros(1000); L_hyb_lfb_stat = zeros(1000); ENTR_hyb_lfb_stat = zeros(1000); count_hyb_lfb = zeros(Int, 1000)
    #RR_hyb1_dep_womf_stat = zeros(1000); DET_hyb1_dep_womf_stat = zeros(1000); L_hyb1_dep_womf_stat = zeros(1000); ENTR_hyb1_dep_womf_stat = zeros(1000); count_hyb1_dep_womf = zeros(Int, 1000)
    #RR_hyb1_dep_stat = zeros(1000); DET_hyb1_dep_stat = zeros(1000); L_hyb1_dep_stat = zeros(1000); ENTR_hyb1_dep_stat = zeros(1000); count_hyb1_dep_stat = zeros(Int, 1000)
    RR_hyb1_dep_womf_wnlfb_stat = zeros(1000); DET_hyb1_dep_womf_wnlfb_stat = zeros(1000); L_hyb1_dep_womf_wnlfb_stat = zeros(1000); ENTR_hyb1_dep_womf_wnlfb_stat = zeros(1000); count_hyb1_dep_womf_wnlfb = zeros(Int, 1000)

    for n in 1:1000
        #h_norb, c_norb = get_hist_diagonal_sampled(x, ε, M)
        #h_imp, c_imp   = get_hist_diagonal_importance_stratified_memory_sampled(x, ε, M)
        #h_ep, c_ep     = get_hist_diagonal_importance_stratified_memory_sampledEP(x, ε, M)
        h_lfb, c_lfb   = get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x, ε, M)
        #h_hyb_lfb, c_hyb_lfb = smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x, ε, M)
        #h_hyb1_dep_womf, c_hyb1_dep_womf = hybrid1_dep_womf(x, ε, M)
        #h_hyb1_dep, c_hyb1_dep = hybrid1_dep(x, ε, M)
        h_hyb1_dep_womf_wnlfb, c_hyb1_dep_womf_wnlfb = hybrid1_dep_womf_wnlfb(x, ε, M)

        #count_norb[n] = c_norb;  
        count_lfb[n] = c_lfb; 
        #count_hyb1_dep_womf[n] = c_hyb1_dep_womf; count_hyb1_dep_stat[n] = c_hyb1_dep; 
        count_hyb1_dep_womf_wnlfb[n] = c_hyb1_dep_womf_wnlfb
        #count_hyb_lfb[n] = c_hyb_lfb; count_imp[n] = c_imp; count_ep[n] = c_ep
        

        #rqa_norb = rqa(h_norb, c_norb);  
        rqa_lfb = rqa(h_lfb, c_lfb); 
        #rqa_hyb1_dep_womf = rqa(h_hyb1_dep_womf, c_hyb1_dep_womf); rqa_hyb1_dep = rqa(h_hyb1_dep, c_hyb1_dep); 
        rqa_hyb1_dep_womf_wnlfb = rqa(h_hyb1_dep_womf_wnlfb, c_hyb1_dep_womf_wnlfb)
        #rqa_imp = rqa(h_imp, c_imp); rqa_ep = rqa(h_ep, c_ep); rqa_hyb_lfb = rqa(h_hyb_lfb, c_hyb_lfb) 
        
        #RR_norb_stat[n] = rqa_norb[1]; DET_norb_stat[n] = rqa_norb[2]; L_norb_stat[n] = rqa_norb[3]; ENTR_norb_stat[n] = rqa_norb[4]
        #RR_imp_stat[n]  = rqa_imp[1];  DET_imp_stat[n]  = rqa_imp[2];  L_imp_stat[n]  = rqa_imp[3];  ENTR_imp_stat[n]  = rqa_imp[4]
        #RR_ep_stat[n]   = rqa_ep[1];   DET_ep_stat[n]   = rqa_ep[2];   L_ep_stat[n]   = rqa_ep[3];   ENTR_ep_stat[n]   = rqa_ep[4]
        RR_lfb_stat[n]  = rqa_lfb[1];  DET_lfb_stat[n]  = rqa_lfb[2];  L_lfb_stat[n]  = rqa_lfb[3];  ENTR_lfb_stat[n]  = rqa_lfb[4]
        #RR_hyb_lfb_stat[n] = rqa_hyb_lfb[1]; DET_hyb_lfb_stat[n] = rqa_hyb_lfb[2]; L_hyb_lfb_stat[n] = rqa_hyb_lfb[3]; ENTR_hyb_lfb_stat[n] = rqa_hyb_lfb[4]
        #RR_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[1]; DET_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[2]; L_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[3]; ENTR_hyb1_dep_womf_stat[n] = rqa_hyb1_dep_womf[4]
        #RR_hyb1_dep_stat[n] = rqa_hyb1_dep[1]; DET_hyb1_dep_stat[n] = rqa_hyb1_dep[2]; L_hyb1_dep_stat[n] = rqa_hyb1_dep[3]; ENTR_hyb1_dep_stat[n] = rqa_hyb1_dep[4]
        RR_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[1]; DET_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[2]; L_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[3]; ENTR_hyb1_dep_womf_wnlfb_stat[n] = rqa_hyb1_dep_womf_wnlfb[4]
    end

    # --- 6. Formatierte Ausgaben ---
    methods = [
        #("Norberts Sampling", b_norb, b_norb_seed, rqa_seed_norb, cnt_seed_norb, count_norb, RR_norb_stat, DET_norb_stat, L_norb_stat, ENTR_norb_stat),
        #("Importance Stratified Memory", b_imp, b_imp_seed, rqa_seed_imp, cnt_seed_imp, count_imp, RR_imp_stat, DET_imp_stat, L_imp_stat, ENTR_imp_stat),
        #("Importance Stratified Memory EP", b_ep, b_ep_seed, rqa_seed_ep, cnt_seed_ep, count_ep, RR_ep_stat, DET_ep_stat, L_ep_stat, ENTR_ep_stat),
        ("Importance Stratified Memory LFBOTH", b_lfb, b_lfb_seed, rqa_seed_lfb, cnt_seed_lfb, count_lfb, RR_lfb_stat, DET_lfb_stat, L_lfb_stat, ENTR_lfb_stat),
        #("Hybrid (LFboth Condition)", b_hyb_lfb, b_hyb_lfb_seed, rqa_seed_hyb_lfb, cnt_seed_hyb_lfb, count_hyb_lfb, RR_hyb_lfb_stat, DET_hyb_lfb_stat, L_hyb_lfb_stat, ENTR_hyb_lfb_stat),
        #("Hybrid1 (dep + womf)", b_hyb1_dep_womf, b_hyb1_dep_womf_seed, rqa_seed_hyb1_dep_womf, cnt_seed_hyb1_dep_womf, count_hyb1_dep_womf, RR_hyb1_dep_womf_stat, DET_hyb1_dep_womf_stat, L_hyb1_dep_womf_stat, ENTR_hyb1_dep_womf_stat),
        #("Hybrid1 (dep)", b_hyb1_dep, b_hyb1_dep_seed, rqa_seed_hyb1_dep, cnt_seed_hyb1_dep, count_hyb1_dep_stat, RR_hyb1_dep_stat, DET_hyb1_dep_stat, L_hyb1_dep_stat, ENTR_hyb1_dep_stat),
        ("Hybrid1 (dep + womf + wnlfb)", b_hyb1_dep_womf_wnlfb, b_hyb1_dep_womf_wnlfb_seed, rqa_seed_hyb1_dep_womf_wnlfb, cnt_seed_hyb1_dep_womf_wnlfb, count_hyb1_dep_womf_wnlfb, RR_hyb1_dep_womf_wnlfb_stat, DET_hyb1_dep_womf_wnlfb_stat, L_hyb1_dep_womf_wnlfb_stat, ENTR_hyb1_dep_womf_wnlfb_stat)
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
# KLASSE 2: BE (bad embedding (antidiagonalen)) PERIODIC (HARMONIC OSCILLATOR) 
# (phasenverschiebung (phase delay (PD)) kleiner als \epsilon => keine gestrichelten linien)
# ---------------------------------------------------------
t_harm_osc_1 = range(0, step=0.1, length=N_points)
x_harm_osc_1 = reshape(sin.(t_harm_osc_1), :, 1)
ε_harm_osc_1 = 0.1 * (maximum(x_harm_osc_1) - minimum(x_harm_osc_1)) 
M_harm_osc = Int(round(0.2 * N_points))

evaluate_system("KLASSE 2: BE+PD PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc_1, ε_harm_osc_1, M_harm_osc)

# ---------------------------------------------------------
# KLASSE 2: PERIODIC (HARMONIC OSCILLATOR) 
# (phasenverschiebung kleiner als \epsilon => keine gestrichelten linien)
# ---------------------------------------------------------
t_harm_osc_2 = range(0, step=0.1, length=N_points)
x_harm_osc_2 = hcat(sin.(t_harm_osc_2), cos.(t_harm_osc_2))
ε_harm_osc_2 = 0.1 * (maximum(x_harm_osc_2) - minimum(x_harm_osc_2))   

evaluate_system_wonob("KLASSE 2: PD(unrecognizable) PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc_2, ε_harm_osc_2, M_harm_osc)

# ---------------------------------------------------------
# KLASSE 2: PERIODIC (HARMONIC OSCILLATOR) 
# (Messrauschen => gestrichelte Linien / Lücken)
# ---------------------------------------------------------
Random.seed!(123)
t_harm_osc_3 = range(0, step=0.1, length=N_points)
x_harm_osc_3 = hcat(sin.(t_harm_osc_3), cos.(t_harm_osc_3)) .+ 0.05 .* randn(N_points, 2)
ε_harm_osc_3 = 0.1 * (maximum(x_harm_osc_3) - minimum(x_harm_osc_3))   

evaluate_system("KLASSE 2: PD(noise) PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc_3, ε_harm_osc_3, M_harm_osc)


# ---------------------------------------------------------
# KLASSE 2: QUASIPERIODIC (HARMONIC OSCILLATOR) 
# (Inkommensurable Frequenzen => gestrichelte Linien / Lücken)
# ---------------------------------------------------------
t_harm_osc_4 = range(0, step=0.1, length=N_points)
x_harm_osc_4 = hcat(sin.(t_harm_osc_4) .+ sin.(sqrt(2).*t_harm_osc_4), cos.(t_harm_osc_4) .+ cos.(sqrt(2).*t_harm_osc_4))
ε_harm_osc_4 = 0.1 * (maximum(x_harm_osc_4) - minimum(x_harm_osc_4))   

evaluate_system("KLASSE 2: QUASIPERIODIC (HARMONIC OSCILLATOR)", x_harm_osc_4, ε_harm_osc_4, M_harm_osc)


# ---------------------------------------------------------
# KLASSE 2: PERIODIC (HARMONIC OSCILLATOR) 
# (Perfekte ?Resonanz?)
# ---------------------------------------------------------
t_harm_osc_5 = range(0, step=0.1*pi, length=N_points)
x_harm_osc_5 = hcat(sin.(t_harm_osc_5), cos.(t_harm_osc_5))
ε_harm_osc_5 = 0.1 * (maximum(x_harm_osc_5) - minimum(x_harm_osc_5))   

evaluate_system_wonob("KLASSE 2: PERIODIC (RESONANZ)", x_harm_osc_5, ε_harm_osc_5, M_harm_osc)


# ---------------------------------------------------------
# KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbares Rauschen
x_noise = reshape(randn(N_points), :, 1)

ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   
M_noise = Int(round(0.2 * N_points))




evaluate_system("KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise, M_noise)


# ---------------------------------------------------------
# KLASSE 4: DRIFT (RANDOM Walk)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbarer Random Walk
x_drift = reshape(cumsum(randn(N_points)), :, 1)

ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   
M_drift = Int(round(0.2 * N_points))




evaluate_system("KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift, M_drift)