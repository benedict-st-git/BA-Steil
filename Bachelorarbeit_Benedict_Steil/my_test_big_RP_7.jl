using BenchmarkTools
using Random
using Statistics
using StaticArrays
using DifferentialEquations

include(joinpath(@__DIR__, "../Norberts_RQA_Code/RPLineLengths.jl"))
include(joinpath(@__DIR__, "my_sampling.jl"))

const LITERATUR_DIR = raw"C:\Users\Benedict\OneDrive\Dokumente\Phzsik\Bachelor\PIK\Bachelorarbeit\Marwan\Literatur"

# ====================================================================
# 0. KERNFUNKTIONEN (Mit SVector & optionaler Artefakt-Korrektur)
# ====================================================================
@inline function is_ridge(x::AbstractVector{<:SVector}, i::Int, j::Int, d2::Float64, N::Int)
    if i - 1 > j
        if sq_dist(x, i - 1, j) < d2
            return false
        end
    end
    if i + 1 <= N
        if sq_dist(x, i + 1, j) <= d2
            return false
        end
    end
    return true
end

function get_hist_diagonal_woRP_2(
    x::AbstractVector{<:SVector}, 
    ε::T, 
    apply_artefact_correction::Bool = false; 
    rng::AbstractRNG = Random.default_rng()
) where {T<:AbstractFloat}
    N = length(x)
    L = zeros(Int, N)
    ε2 = Float64(ε^2)

    W_theiler = apply_artefact_correction ? estimate_W(rng, x, Float64(ε)) : 0
    i_start   = apply_artefact_correction ? min(W_theiler + 2, N + 1) : 2

    @inbounds for i in i_start:N
        cnt = 0
        @inbounds for j in 1:(N - i + 1)
            r = i + j - 1
            c = j
            
            D2 = sq_dist(x, r, c)
            is_black = D2 <= ε2
            
            if is_black && apply_artefact_correction
                is_black = is_ridge(x, r, c, D2, N)
            end
            
            if is_black
                cnt += 1
            else
                if cnt > 0
                    L[cnt] += 1
                    cnt = 0
                end
            end
        end
        if cnt > 0
            L[cnt] += 1
        end
    end

    return L
end

function activate_boxes_smi(
    rng::AbstractRNG, 
    x::AbstractVector{<:SVector}, 
    ε2::Float64, 
    s_tilde::Float64, 
    total_pairs::Int, 
    estimated_tries_per_box::Int, 
    W_theiler::Int, 
    apply_correction::Bool
)
    N = length(x)
    
    offset = 0
    if apply_correction
        W_eff = clamp(W_theiler, 0, N - 2)
        offset = (W_eff * N) - ((W_eff * (W_eff + 1)) >> 1)
    end
    
    total_effective_pairs = max(1, total_pairs - offset)
    num_boxes = min(total_effective_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = max(1, total_effective_pairs ÷ num_boxes)
    
    active_boxs = Vector{Int}(undef, num_boxes)
    active_box_count = 0
    
    N2_1_int = 2 * N - 1
    N2_1_sq  = Float64(N2_1_int)^2
    
    @inbounds for current_box in 1:num_boxes
        l_b = min(total_pairs, offset + (current_box - 1) * box_length_dyn + 1)
        u_b = current_box == num_boxes ? total_pairs : min(total_pairs, offset + current_box * box_length_dyn)
        u_b = max(l_b, u_b)
        
        for _ in 1:estimated_tries_per_box
            idx = rand(rng, l_b:u_b)
            
            val = max(0.0, N2_1_sq - 8.0 * Float64(idx))
            S_int = trunc(Int, sqrt(val))
            d = clamp((N2_1_int - S_int + 1) >> 1, 1, N - 1)
            d_minus = d - 1
            j_start = clamp(idx - (d_minus * N - ((d_minus * d) >> 1)), 1, N - d)
            i_start = j_start + d
            
            d2 = sq_dist(x, i_start, j_start)
            if d2 <= ε2
                if apply_correction && !is_ridge(x, i_start, j_start, d2, N)
                    continue
                end
                
                active_box_count += 1
                active_boxs[active_box_count] = current_box
                break
            end
        end
    end
    
    return active_boxs, active_box_count, offset, box_length_dyn, num_boxes
end

function rand_sample_lfb_svec(
    rng::AbstractRNG, 
    x::AbstractVector{<:SVector}, 
    ε2::Float64, 
    M::Int, 
    W_theiler::Int, 
    apply_correction::Bool
)
    N = length(x)
    L_local = zeros(Float64, N)
    
    total_pairs = (N * (N - 1)) >> 1
    max_searches = max(M * 200, total_pairs << 1)
    
    K = 50; W_conv = 5; tol = 1e-3; min_samples = 500   
    det_ring = zeros(Float64, W_conv); l_ring = zeros(Float64, W_conv)
    ring_idx = 1; history_count = 0; sum_n2_L = 0.0; sum_L2 = 0.0; count = 0; countAll = 0 

    min_dist = apply_correction ? max(1, W_theiler + 1) : 1

    while count < M
        if countAll > max_searches; break; end
        
        u1 = rand(rng, 1:N)
        u2 = rand(rng, 1:N)
        if abs(u1 - u2) < min_dist; continue; end
        
        countAll += 1                 
        j_start, i_start = minmax(u1, u2)

        d2 = sq_dist(x, i_start, j_start)
        if d2 > ε2; continue; end
        
        if apply_correction && !is_ridge(x, i_start, j_start, d2, N)
            continue
        end

        cnt = 1 
        @inbounds for k_offset in 1:(N - i_start) 
            if sq_dist(x, i_start + k_offset, j_start + k_offset) <= ε2; cnt += 1; else; break; end
        end
        @inbounds for k_offset in 1:(j_start - 1) 
            if sq_dist(x, i_start - k_offset, j_start - k_offset) <= ε2; cnt += 1; else; break; end
        end
        
        if cnt > 0 
            weight = 1.0 / cnt
            L_local[cnt] += weight    
            count += 1                

            is_long = cnt >= 2
            sum_n2_L += is_long ? 1.0 : 0.0
            sum_L2   += is_long ? weight : 0.0

            if count % K == 0 && count >= min_samples
                det_ring[ring_idx] = sum_n2_L / count
                l_ring[ring_idx]   = sum_n2_L / sum_L2
                ring_idx = (ring_idx % W_conv) + 1
                history_count += 1
                
                if history_count >= W_conv && calc_rel_change(det_ring) < tol && calc_rel_change(l_ring) < tol
                    break
                end
            end
        end          
    end
    
    return L_local, countAll
end

function smi_lfb_svec(
    rng::AbstractRNG, 
    x::AbstractVector{<:SVector}, 
    ε2::Float64, 
    M::Int, 
    estimated_RR::Float64, 
    s::Union{Float64, Nothing}, 
    W_theiler::Int, 
    apply_correction::Bool
)
    N = length(x)
    L_local = zeros(Float64, N)
    
    total_pairs = (N * (N - 1)) >> 1
    max_searches = max(M * 200, total_pairs << 1)
    
    K = 50; W_conv = 5; tol = 1e-3; min_samples = 500   
    det_ring = zeros(Float64, W_conv); l_ring = zeros(Float64, W_conv)
    ring_idx = 1; history_count = 0; sum_n2_L = 0.0; sum_L2 = 0.0; count = 0; countAll = 0 

    actual_s = (s !== nothing) ? s : (estimated_RR < 0.05 ? 5.0 : (estimated_RR > 0.2 ? 0.5 : 1.0))
    estimated_tries_per_box = (estimated_RR < 0.05 ? 50 : (estimated_RR > 0.2 ? 12 : 24))
    s_tilde = M * actual_s
    
    active_boxs, active_box_count, offset, box_length_dyn, num_boxes = activate_boxes_smi(
        rng, x, ε2, s_tilde, total_pairs, estimated_tries_per_box, W_theiler, apply_correction
    )

    if active_box_count == 0
        return L_local, countAll
    end
    
    N2_1_int = 2 * N - 1
    N2_1_sq  = Float64(N2_1_int)^2
    sum_n_L  = 0.0

    while count < M
        if countAll > max_searches; break; end
        
        @inbounds current_box = active_boxs[rand(rng, 1:active_box_count)]
        countAll += 1                 
        
        l_b = min(total_pairs, offset + (current_box - 1) * box_length_dyn + 1)
        u_b = current_box == num_boxes ? total_pairs : min(total_pairs, offset + current_box * box_length_dyn)
        u_b = max(l_b, u_b)
        idx = rand(rng, l_b:u_b)     

        val = max(0.0, N2_1_sq - 8.0 * Float64(idx))
        S_int = trunc(Int, sqrt(val))
        d = clamp((N2_1_int - S_int + 1) >> 1, 1, N - 1)
        d_minus = d - 1
        j_start = clamp(idx - (d_minus * N - ((d_minus * d) >> 1)), 1, N - d)
        i_start = j_start + d                 

        d2 = sq_dist(x, i_start, j_start)
        if d2 > ε2; continue; end
        
        if apply_correction && !is_ridge(x, i_start, j_start, d2, N)
            continue
        end

        cnt = 1 
        @inbounds for k_offset in 1:(N - i_start) 
            if sq_dist(x, i_start + k_offset, j_start + k_offset) <= ε2; cnt += 1; else; break; end
        end
        @inbounds for k_offset in 1:(j_start - 1) 
            if sq_dist(x, i_start - k_offset, j_start - k_offset) <= ε2; cnt += 1; else; break; end
        end
        
        if cnt > 0 
            weight = 1.0 / cnt
            L_local[cnt] += weight         
            count += 1                
            
            sum_n_L  += cnt * weight
            is_long = cnt >= 2
            sum_n2_L += is_long ? (cnt * weight) : 0.0
            sum_L2   += is_long ? weight : 0.0

            if count % K == 0 && count >= min_samples
                det_ring[ring_idx] = sum_n2_L / sum_n_L
                l_ring[ring_idx]   = sum_n2_L / sum_L2
                ring_idx = (ring_idx % W_conv) + 1
                history_count += 1
                if history_count >= W_conv && calc_rel_change(det_ring) < tol && calc_rel_change(l_ring) < tol
                    break
                end
            end
        end          
    end

    countAll_correct_scaled = Int(div(Int128(countAll) * num_boxes, active_box_count))
    return L_local, countAll_correct_scaled
end

function hybrid1_dep_wnlfb(
    x::AbstractVector{<:SVector}, 
    ε::T, 
    M::Int; 
    s::Union{Float64, Nothing} = nothing, 
    auto_s::Bool = true, 
    epsilon_quantile::Bool = false, 
    apply_artefact_correction::Bool = false, 
    rng::AbstractRNG = Random.default_rng()
) where {T<:AbstractFloat}
    N = length(x)                  
    
    if epsilon_quantile
        target_rr = 0.03
        ε2 = estimate_epsilon_sq_by_rr(rng, x, target_rr, samples=100000)
        ε_eff = sqrt(ε2)
    else
        ε2 = Float64(ε^2)
        ε_eff = Float64(ε)
    end
    
    check_length = clamp(N ÷ 20, 15, 100) 
    max_misses = 3 
    period_equidistance_error = 2 
    W_theiler = estimate_W(rng, x, ε_eff) 
    W_soujorn = max(3, W_theiler)           
    
    estimated_RR = estimate_RR_svec(rng, x, ε_eff)
    max_fails = clamp(round(Int, 3.0 / max(estimated_RR, 0.01)), 15, 150)
   
    is_periodic = check_periodicity_block(x, N, check_length, max_misses, period_equidistance_error, W_soujorn, max_fails, ε2)

    if is_periodic
        return rand_sample_lfb_svec(rng, x, ε2, M, W_theiler, apply_artefact_correction)
    else
        return smi_lfb_svec(rng, x, ε2, M, estimated_RR, s, W_theiler, apply_artefact_correction)
    end
end

# ====================================================================
# 1. DUAL-LOGGER, SVector-KONVERTIERUNG & BASE-JULIA CSV-LOADER
# ====================================================================
@inline function log_println(io::IO, args...)
    println(stdout, args...)
    flush(stdout)
    if io !== stdout
        println(io, args...)
        flush(io)
    end
end

@inline function to_svec(x_mat::Matrix{Float64})
    D = size(x_mat, 2)
    mat_t = copy(transpose(x_mat))
    return reinterpret(SVector{D, Float64}, vec(mat_t))
end

"""
    load_csv_matrix(filepath::String)

Liest eine vorbereitete CSV-Matrix ausschließlich mit Base-Julia-Funktionen ein
(keine externen Pakete wie DelimitedFiles oder CSV erforderlich).
"""
function load_csv_matrix(filepath::String)
    lines = filter(!isempty, readlines(filepath))
    n_rows = length(lines)
    first_parts = split(lines[1], ',')
    n_cols = length(first_parts)
    mat = Matrix{Float64}(undef, n_rows, n_cols)
    @inbounds for r in 1:n_rows
        parts = split(lines[r], ',')
        for c in 1:n_cols
            mat[r, c] = parse(Float64, parts[c])
        end
    end
    return mat
end

# ====================================================================
# 2. KOMPAKTE BENCHMARK-ROUTINEN
# ====================================================================
@noinline function evaluate_baseline(io::IO, name::String, x_svec, ε::Float64, apply_corr::Bool, total_pairs::Int)
    log_println(io, "\n--- BASELINE: $name ---")
    b_worp = @benchmark get_hist_diagonal_woRP_2($x_svec, $ε, $apply_corr)
    L_worp = get_hist_diagonal_woRP_2(x_svec, ε, apply_corr)
    
    eff_pairs = total_pairs
    if apply_corr
        W_t = clamp(estimate_W(Random.default_rng(), x_svec, ε), 0, length(x_svec) - 2)
        N_len = length(x_svec)
        eff_pairs = max(1, total_pairs - ((W_t * N_len) - ((W_t * (W_t + 1)) >> 1)))
    end
    rqa_res = rqa(L_worp, eff_pairs)

    t_ms = round(median(b_worp.times) / 1e6, digits=2)
    log_println(io, "Runtime: $t_ms ms | Allocs: $(b_worp.allocs) | Mem: $(round(b_worp.memory / 1024, digits=2)) KiB")
    log_println(io, "RR:      $(round(rqa_res[1], digits=5))")
    log_println(io, "DET:     $(round(rqa_res[2], digits=5))")
    log_println(io, "L:       $(round(rqa_res[3], digits=5))")
    log_println(io, "ENTR:    $(round(rqa_res[4], digits=5))")
    return rqa_res
end

@noinline function evaluate_single_sampler(
    io::IO, name::String, func::F, data::D, ref_rqa,
    cnt_stat::Vector{Float64}, rr_stat::Vector{Float64},
    det_stat::Vector{Float64}, l_stat::Vector{Float64}, entr_stat::Vector{Float64}
) where {F, D}
    log_println(io, "\n>>> EVALUATING: $name <<<")

    b_woseed = @benchmark $func($data)
    b_seed   = @benchmark $func($data) setup=(Random.seed!(42)) evals=1

    t_woseed = round(median(b_woseed.times) / 1e6, digits=2)
    t_seed   = round(median(b_seed.times) / 1e6, digits=2)
    log_println(io, "  [Benchmark W/O Seed]   $t_woseed ms | Allocs: $(b_woseed.allocs) | Mem: $(round(b_woseed.memory / 1024, digits=2)) KiB")
    log_println(io, "  [Benchmark WITH Seed]  $t_seed ms | Allocs: $(b_seed.allocs) | Mem: $(round(b_seed.memory / 1024, digits=2)) KiB")

    Random.seed!(42)
    h_seed, c_seed = func(data)
    rqa_s = rqa(h_seed, c_seed)

    log_println(io, "  [Exakt Seed 42]        countAll: $c_seed")
    log_println(io, "    RR:   $(round(rqa_s[1], digits=4)) (Δ: $(round(rqa_s[1] - ref_rqa[1], digits=5)))")
    log_println(io, "    DET:  $(round(rqa_s[2], digits=4)) (Δ: $(round(rqa_s[2] - ref_rqa[2], digits=5)))")
    log_println(io, "    L:    $(round(rqa_s[3], digits=4)) (Δ: $(round(rqa_s[3] - ref_rqa[3], digits=5)))")
    log_println(io, "    ENTR: $(round(rqa_s[4], digits=4)) (Δ: $(round(rqa_s[4] - ref_rqa[4], digits=5)))")

    n_stat = length(cnt_stat)
    @inbounds for n in 1:n_stat
        h_st, c_st = func(data)
        cnt_stat[n] = Float64(c_st)
        r_st = rqa(h_st, c_st)
        rr_stat[n]   = r_st[1]
        det_stat[n]  = r_st[2]
        l_stat[n]    = r_st[3]
        entr_stat[n] = r_st[4]
    end

    log_println(io, "  [Statistisch $n_stat Läufe]")
    log_println(io, "    countAll: $(round(mean(cnt_stat), digits=1)) ± $(round(std(cnt_stat), digits=1))")
    log_println(io, "    RR:   $(round(mean(rr_stat), digits=4)) ± $(round(std(rr_stat), digits=5)) (Δ: $(round(mean(rr_stat) - ref_rqa[1], digits=5)))")
    log_println(io, "    DET:  $(round(mean(det_stat), digits=4)) ± $(round(std(det_stat), digits=5)) (Δ: $(round(mean(det_stat) - ref_rqa[2], digits=5)))")
    log_println(io, "    L:    $(round(mean(l_stat), digits=4)) ± $(round(std(l_stat), digits=5)) (Δ: $(round(mean(l_stat) - ref_rqa[3], digits=5)))")
    log_println(io, "    ENTR: $(round(mean(entr_stat), digits=4)) ± $(round(std(entr_stat), digits=5)) (Δ: $(round(mean(entr_stat) - ref_rqa[4], digits=5)))")
end

function evaluate_system_optimized(io::IO, system_name::String, x_mat::Matrix{Float64}, ε::Float64, M::Int; run_norb::Bool = true, n_stat::Int = 30)
    log_println(io, "\n" * "="^72)
    log_println(io, " SYSTEM: $system_name (N=$(size(x_mat,1)), dim=$(size(x_mat,2)))")
    log_println(io, "="^72)
    
    N = size(x_mat, 1)
    total_pairs = (N * (N - 1)) >> 1
    x_svec = to_svec(x_mat)
    
    ref_rqa_std  = evaluate_baseline(io, "woRP_2 (Standard, apply_correction=false)", x_svec, ε, false, total_pairs)
    ref_rqa_corr = evaluate_baseline(io, "woRP_2 (Sceletonized, apply_correction=true)", x_svec, ε, true, total_pairs)

    cnt_stat  = zeros(Float64, n_stat)
    rr_stat   = zeros(Float64, n_stat)
    det_stat  = zeros(Float64, n_stat)
    l_stat    = zeros(Float64, n_stat)
    entr_stat = zeros(Float64, n_stat)
    
    if run_norb
        evaluate_single_sampler(io, "Norbert (Matrix)", d -> get_hist_diagonal_sampled(d, ε, M), x_mat, ref_rqa_std, cnt_stat, rr_stat, det_stat, l_stat, entr_stat)
    end
    
    evaluate_single_sampler(io, "SMI LFBOTH (Matrix)", d -> get_hist_diagonal_importance_stratified_memory_sampled_LFboth(d, ε, M), x_mat, ref_rqa_std, cnt_stat, rr_stat, det_stat, l_stat, entr_stat)
    evaluate_single_sampler(io, "Hybrid1 (SVector) [apply_artefact_correction=false]", d -> hybrid1_dep_wnlfb(d, ε, M; apply_artefact_correction=false), x_svec, ref_rqa_std, cnt_stat, rr_stat, det_stat, l_stat, entr_stat)
    evaluate_single_sampler(io, "Hybrid1 (SVector) [apply_artefact_correction=true]", d -> hybrid1_dep_wnlfb(d, ε, M; apply_artefact_correction=true), x_svec, ref_rqa_corr, cnt_stat, rr_stat, det_stat, l_stat, entr_stat)
end

function evaluate_csv_dataset(io::IO, title::String, filename::String, M::Int; run_norb::Bool = true)
    filepath = joinpath(LITERATUR_DIR, filename)
    if !isfile(filepath)
        log_println(io, "\n[WARNUNG] Datei nicht gefunden: $filepath")
        log_println(io, "Bitte führe zuvor einmalig `prepare_thesis_datasets.py` aus!")
        return
    end
    x_mat = load_csv_matrix(filepath)
    ε_val = 0.1 * (maximum(x_mat) - minimum(x_mat))
    evaluate_system_optimized(io, title, x_mat, ε_val, M; run_norb=run_norb)
end

# ====================================================================
# 3. LOKALE MODELL-GENERATOREN & HAUPTSCHLEIFE (KLASSEN 1 BIS 8)
# ====================================================================
function roessler!(du, u, p, t)
    a, b, c = p
    du[1] = -u[2] - u[3]
    du[2] = u[1] + a * u[2]
    du[3] = b + u[3] * (u[1] - c)
end

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

function generate_logistic_map(N::Int; a::Float64=4.0, x0::Float64=0.4)
    x = zeros(Float64, N + 500, 1)
    x[1, 1] = x0
    @inbounds for i in 1:(N + 499)
        x[i+1, 1] = a * x[i, 1] * (1.0 - x[i, 1])
    end
    return x[501:end, :]
end

function generate_ar1_red_noise(N::Int; α::Float64=0.86, seed::Int=123)
    Random.seed!(seed)
    x = zeros(Float64, N, 1)
    x[1, 1] = randn()
    @inbounds for i in 1:(N-1)
        x[i+1, 1] = α * x[i, 1] + 0.5 * randn()
    end
    return x
end

function main_test_suite(io::IO = stdout)
    N_points = 10000
    M_default = Int(round(0.2 * N_points))

    # --- KLASSE 1: KONTINUIERLICHES STANDARD-CHAOS ---
    prob_r = ODEProblem(roessler!, [-6.2668, -1.3413, 0.0166], (0.0, (N_points + 100 - 1) * 0.2), (0.2, 0.2, 5.7)) 
    sol_r  = solve(prob_r, Tsit5(), saveat=0.2) 
    x_c1   = copy(transpose(reduce(hcat, sol_r.u)))[101:end, :]
    ε_c1   = 0.1 * (maximum(x_c1) - minimum(x_c1))   
    evaluate_system_optimized(io, "KLASSE 1A: CHAOS (ROESSLER STANDARD)", x_c1, ε_c1, M_default; run_norb=true)

    x_lorenz = generate_lorenz(N_points)
    ε_lorenz = 0.1 * (maximum(x_lorenz) - minimum(x_lorenz))   
    evaluate_system_optimized(io, "KLASSE 1B: CHAOS (LORENZ SYSTEM)", x_lorenz, ε_lorenz, M_default; run_norb=true)

    # --- KLASSE 2: PERIODISCHE & QUASIPERIODISCHE SYSTEME ---
    t_h1 = range(0, step=0.1, length=N_points)
    x_h1 = reshape(sin.(t_h1), :, 1)
    ε_h1 = 0.1 * (maximum(x_h1) - minimum(x_h1)) 
    evaluate_system_optimized(io, "KLASSE 2A: BE+PD PERIODIC (HARMONIC OSCILLATOR)", x_h1, ε_h1, M_default; run_norb=true)

    t_h2 = range(0, step=0.1, length=N_points)
    x_h2 = hcat(sin.(t_h2), cos.(t_h2))
    ε_h2 = 0.1 * (maximum(x_h2) - minimum(x_h2))   
    evaluate_system_optimized(io, "KLASSE 2B: PD(unrecognizable) PERIODIC", x_h2, ε_h2, M_default; run_norb=false)

    Random.seed!(123)
    t_h3 = range(0, step=0.1, length=N_points)
    x_h3 = hcat(sin.(t_h3), cos.(t_h3)) .+ 0.05 .* randn(N_points, 2)
    ε_h3 = 0.1 * (maximum(x_h3) - minimum(x_h3))   
    evaluate_system_optimized(io, "KLASSE 2C: PD(noise) PERIODIC", x_h3, ε_h3, M_default; run_norb=true)

    t_h4 = range(0, step=0.1, length=N_points)
    x_h4 = hcat(sin.(t_h4) .+ sin.(sqrt(2).*t_h4), cos.(t_h4) .+ cos.(sqrt(2).*t_h4))
    ε_h4 = 0.1 * (maximum(x_h4) - minimum(x_h4))   
    evaluate_system_optimized(io, "KLASSE 2D: QUASIPERIODIC", x_h4, ε_h4, M_default; run_norb=true)

    t_h5 = range(0, step=0.1*pi, length=N_points)
    x_h5 = hcat(sin.(t_h5), cos.(t_h5))
    ε_h5 = 0.1 * (maximum(x_h5) - minimum(x_h5))   
    evaluate_system_optimized(io, "KLASSE 2E: PERIODIC (RESONANZ)", x_h5, ε_h5, M_default; run_norb=false)

    # --- KLASSE 3: WEISSES RAUSCHEN ---
    Random.seed!(123) 
    x_noise = reshape(randn(N_points), :, 1)
    ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   
    evaluate_system_optimized(io, "KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise, M_default; run_norb=true)

    # --- KLASSE 4: DRIFT / RANDOM WALK ---
    Random.seed!(123) 
    x_drift = reshape(cumsum(randn(N_points)), :, 1)
    ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   
    evaluate_system_optimized(io, "KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift, M_default; run_norb=true)

    # --- KLASSE 5 (NORBERT EMPFEHLUNG 1): STRANGE NONCHAOTIC DYNAMICS (Aus Literatur-Ordner) ---
    evaluate_csv_dataset(io, "KLASSE 5A: STRANGE NONCHAOTIC ATTRACTOR (CUBIC MAP HH-ROUTE)", "sna_cubic_heagy_hammel_N$(N_points).csv", M_default; run_norb=true)
    evaluate_csv_dataset(io, "KLASSE 5B: STRANGE NONCHAOTIC ATTRACTOR (FORCED LOGISTIC FRACTALIZATION)", "sna_logistic_fractal_N$(N_points).csv", M_default; run_norb=true)

    # --- KLASSE 6 (NORBERT EMPFEHLUNG 2): DOPPELPENDEL QUANTEN- & KLASSISCHES MODELL (Aus Literatur-Ordner) ---
    evaluate_csv_dataset(io, "KLASSE 6A: QUANTUM DOUBLE PENDULUM (ROTOR BASIS, Perotti PRE 2004)", "quantum_double_pendulum_Perotti2004_N$(N_points).csv", M_default; run_norb=true)
    evaluate_csv_dataset(io, "KLASSE 6B: CLASSICAL HAMILTONIAN DOUBLE PENDULUM (CHAOTIC REGIME)", "classical_double_pendulum_chaotic_N$(N_points).csv", M_default; run_norb=true)

    # --- KLASSE 7 (NORBERT EMPFEHLUNG 3): GEOFON SEISMIK STROKKUR GEYSIR (Aus Literatur-Ordner) ---
    evaluate_csv_dataset(io, "KLASSE 7A: GEOFON 7L SEISMIC GEYSER (STROKKUR 2017, TAKENS EMBEDDED)", "geofon_7L_2017_Strokkur_G1_embedded_N$(N_points).csv", M_default; run_norb=true)
    evaluate_csv_dataset(io, "KLASSE 7B: GEOFON 2Z SEISMIC GEYSER (STROKKUR 2020, TAKENS EMBEDDED)", "geofon_2Z_2020_Strokkur_GE2_embedded_N$(N_points).csv", M_default; run_norb=true)

    # --- KLASSE 8: WEITERE SCHLÜSSEL-SYSTEME AUS MARWAN ET AL. (2007, 2026) ---
    x_log4 = generate_logistic_map(N_points; a=4.0)
    ε_log4 = 0.1 * (maximum(x_log4) - minimum(x_log4))
    evaluate_system_optimized(io, "KLASSE 8A: DISCRETE CHAOS WITHOUT TANGENTIAL MOTION (LOGISTIC MAP a=4.0)", x_log4, ε_log4, M_default; run_norb=true)

    x_log_lam = generate_logistic_map(N_points; a=3.679)
    ε_log_lam = 0.1 * (maximum(x_log_lam) - minimum(x_log_lam))
    evaluate_system_optimized(io, "KLASSE 8B: LAMINAR INTERMITTENCY / BAND MERGING (LOGISTIC MAP a=3.679)", x_log_lam, ε_log_lam, M_default; run_norb=true)

    prob_rf = ODEProblem(roessler!, [-6.2668, -1.3413, 0.0166], (0.0, (N_points + 100 - 1) * 0.2), (0.2925, 0.1, 8.5))
    sol_rf  = solve(prob_rf, Tsit5(), saveat=0.2)
    x_rf    = copy(transpose(reduce(hcat, sol_rf.u)))[101:end, :]
    ε_rf    = 0.1 * (maximum(x_rf) - minimum(x_rf))
    evaluate_system_optimized(io, "KLASSE 8C: NON-PHASE-COHERENT CHAOS (ROESSLER FUNNEL REGIME)", x_rf, ε_rf, M_default; run_norb=true)

    x_ar1 = generate_ar1_red_noise(N_points; α=0.86)
    ε_ar1 = 0.1 * (maximum(x_ar1) - minimum(x_ar1))
    evaluate_system_optimized(io, "KLASSE 8D: CORRELATED RED CLIMATE NOISE (AR(1), alpha=0.86)", x_ar1, ε_ar1, M_default; run_norb=true)
end

if !isdefined(Main, :AUTO_RUN_MAIN) || Main.AUTO_RUN_MAIN
    ausgabe_datei = joinpath(@__DIR__, "my_test_ausgaben_7.txt")
    open(ausgabe_datei, "w") do file_io
        main_test_suite(file_io)
    end
end