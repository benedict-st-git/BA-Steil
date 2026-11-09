# needed ?packages?
using Statistics
using StaticArrays
using Random


"""
    Sampling 1: memory sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_memory_sampled(x::AbstractMatrix{T}, ε::T, M::Int) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    visited_gauß_idxs = falses(total_pairs) # To avoid calculating distances for the same pair multiple times
    while count < M
        countAll += 1                 # Count number of searches
        idx = rand(1:total_pairs)     # Random start pair (i,j) in linear notation
        if visited_gauß_idxs[idx]
            continue # Skip already processed idxs
        end
        visited_gauß_idxs[idx] = true # Mark this idx as processed
        i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
        j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

        #println("i: ", i_start, "  j: ", j_start)

        # Check if R(i_start,j_start) = 1 (start point)
        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end

        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = 0.0
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end

        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = 0.0
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end

        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)

            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0



            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples

                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2

                push!(det_history, det_val)
                push!(l_history,   l_val)


                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end]
                    l_window   = l_history[end-W+1:end]

                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end
    
    end

    return L_local, countAll
end


"""
Sampling 2.0: Stratified Sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_stratified_sampled(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    if s !== nothing
        actual_s = s
    elseif auto_s
        estimated_RR = estimate_RR(x, ε)

        if estimated_RR < 0.05
            # SEHR DÜNNES RP (z.B. Rössler): 
            # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
            # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
            actual_s = 5.0   
            
        elseif estimated_RR > 0.2
            # SEHR DICHTES RP (z.B. Rauschen): 
            # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
            # um Overhead zu sparen.
            actual_s = 0.5   
            
        else
            # NORMALFALL:
            actual_s = 1.0   
        end

    else
        actual_s = 1.0
    end
    
    s_tilde = M * actual_s
    # box_length_dyn = 4000
    # print(box_length_dyn)
    num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = total_pairs ÷ num_boxes
    current_box = 0

    while count < M

        current_box += 1
        if current_box > num_boxes
            current_box = 1
        end

        lower_bound = (current_box-1) * box_length_dyn + 1

        if current_box == num_boxes
            upper_bound = total_pairs
        else
            upper_bound = current_box * box_length_dyn
        end

        countAll += 1                 # Count number of searches
        idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
        i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
        j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j
        #println("i: ", i_start, "  j: ", j_start)
        # Check if R(i_start,j_start) = 1 (start point)

        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end
        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = 0.0
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end
        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = 0.0
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end
        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)
            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0
            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples
                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2
                push!(det_history, det_val)
                push!(l_history,   l_val)
                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end]
                    l_window   = l_history[end-W+1:end]
                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end          
    end

    return L_local, countAll
end


"""
    Sampling 3.1: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    xxxx
"""

function get_hist_diagonal_importance_stratified_memory_sampled(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    if s !== nothing
        actual_s = s
    elseif auto_s
        estimated_RR = estimate_RR(x, ε)

        if estimated_RR < 0.05
            # SEHR DÜNNES RP (z.B. Rössler): 
            # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
            # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
            actual_s = 5.0   
            
        elseif estimated_RR > 0.2
            # SEHR DICHTES RP (z.B. Rauschen): 
            # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
            # um Overhead zu sparen.
            actual_s = 0.5   
            
        else
            # NORMALFALL:
            actual_s = 1.0   
        end

    else
        actual_s = 1.0
    end
    
    s_tilde = M * actual_s
    # box_length_dyn = 4000
    # print(box_length_dyn)
    num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = total_pairs ÷ num_boxes
    current_box = 0

    active_boxs = Int[]
    for current_box in 1:num_boxes
        for _ in 1:10
            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
            d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein Linienstart, nächster Versuch
            else
                push!(active_boxs, current_box)
                break
            end
        end
    end

    current_box = 0
    while count < M

        current_box = rand(active_boxs) 
        #if current_box > num_boxes
        #    current_box = 1
        #end

        lower_bound = (current_box-1) * box_length_dyn + 1
        upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

        countAll += 1                 # Count number of searches
        idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
        d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
        previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
        j_start = idx - previous_elements     # spalte
        i_start = j_start + d

        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end
        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = zero(T) # verbesserung: zero(T) ?!
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end
        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = zero(T) # verbesserung: zero(T) ?!
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end
        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)
            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0
            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples
                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2
                push!(det_history, det_val)
                push!(l_history,   l_val)
                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end] # Verbesserung: @view added better?!?
                    l_window   = l_history[end-W+1:end]
                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end          
    end

    countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
    return L_local, countAll_correct_scaled
end

"""
    Sampling 3.2: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    xxxx
"""

function get_hist_diagonal_importance_stratified_memory_sampled_LFboth(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Float64, N)           # Histogram for line lengths - mit typ float64, wegen korrektur in zählung der linien bestimmter länge (1/cnt)
    # L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    if s !== nothing
        actual_s = s
    elseif auto_s
        estimated_RR = estimate_RR(x, ε)

        if estimated_RR < 0.05
            # SEHR DÜNNES RP (z.B. Rössler): 
            # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
            # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
            actual_s = 5.0   
            estimated_tries_per_box = 50
            
        elseif estimated_RR > 0.2
            # SEHR DICHTES RP (z.B. Rauschen): 
            # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
            # um Overhead zu sparen.
            actual_s = 0.5   
            estimated_tries_per_box = 12
            
        else
            # NORMALFALL (estimated_RR zwischen 0.05 und 0.2 (mittel ca. 0.1)):
            actual_s = 1.0   
            estimated_tries_per_box = 24
        end

    else
        actual_s = 1.0
        estimated_tries_per_box = 24
    end
    
    s_tilde = M * actual_s
    # box_length_dyn = 4000
    # print(box_length_dyn)
    num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = total_pairs ÷ num_boxes
    current_box = 0

    active_boxs = Int[]
    for current_box in 1:num_boxes
        for _ in 1:estimated_tries_per_box # konstante anzahl an versuchen (z.B.: 10) pro box? oder dynamisch (wharshcienlichkeit weiß zu treffen nach der estimated_RR bei 7.7 (siehe oben))?
            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
            d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  
            else
                push!(active_boxs, current_box)
                break
            end
        end
    end

    current_box = 0
    while count < M

        current_box = rand(active_boxs) 
        #if current_box > num_boxes
        #    current_box = 1
        #end

        lower_bound = (current_box-1) * box_length_dyn + 1
        upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

        countAll += 1                 # Count number of searches
        idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
        # weshalb das folgende? mathe verstehen.
        d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
        previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
        j_start = idx - previous_elements     # spalte
        i_start = j_start + d                 # zeile größer spalte => oberes dreieck (diagonale von links unten nach rechts oben und achsen-nullpunkt links unten)

        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein schwarzer Punkt, nächster Versuch
        end
        
        # Black Point found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start) # weshalb klappt das?
            D2_line_following = zero(T) # verbesserung: zero(T) ?!
            for k in 1:dim
                D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line_following <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end
        @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
            D2_line_prev = zero(T) # verbesserung: zero(T) ?!
            for k in 1:dim
                D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
            end
            if D2_line_prev <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end
        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            weight = 1/cnt
            L_local[cnt] += weight         # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
            count += 1                # Count found lines (only counted if a line was found)
            sum_n_L  += cnt * weight
            sum_n2_L += cnt >= 2 ? cnt*weight : 0
            sum_L2   += cnt >= 2 ? weight  : 0
            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples
                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2
                push!(det_history, det_val)
                push!(l_history,   l_val)
                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end] # verbesserung: @view added better?!?
                    l_window   = l_history[end-W+1:end]
                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end          
    end

    countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
    return L_local, countAll_correct_scaled
end


"""
    Sampling 3.3: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    xxxx
"""

function get_hist_diagonal_importance_stratified_memory_sampledEP(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    if s !== nothing
        actual_s = s
    elseif auto_s
        estimated_RR = estimate_RR(x, ε)

        if estimated_RR < 0.05
            # SEHR DÜNNES RP (z.B. Rössler): 
            # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
            # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
            actual_s = 5.0   
            
        elseif estimated_RR > 0.2
            # SEHR DICHTES RP (z.B. Rauschen): 
            # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
            # um Overhead zu sparen.
            actual_s = 0.5   
            
        else
            # NORMALFALL:
            actual_s = 1.0   
        end

    else
        actual_s = 1.0
    end
    
    s_tilde = M * actual_s
    # box_length_dyn = 4000
    # print(box_length_dyn)
    num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = total_pairs ÷ num_boxes
    current_box = 0

    active_boxs = Int[]
    for current_box in 1:num_boxes
        for _ in 1:10
            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
            d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein Linienstart, nächster Versuch
            else
                push!(active_boxs, current_box)
                break
            end
        end
    end

    current_box = 0
    while count < M

        current_box = rand(active_boxs) 
        #if current_box > num_boxes
        #    current_box = 1
        #end

        lower_bound = (current_box-1) * box_length_dyn + 1
        upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

        countAll += 1                 # Count number of searches
        idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
        d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
        previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
        j_start = idx - previous_elements     # spalte
        i_start = j_start + d

        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end
        # Check if following point R(i_start+1, j_start+1) = 0 (end of a line)
        if i_start == N || j_start == N
            # We are at the lower border – no previous points
        else
            D2_follow = zero(T) # verbesserung: zero(T) ?!
            @inbounds for k in 1:dim
                D2_follow += (x[i_start+1,k] - x[j_start+1,k])^2
            end
            if D2_follow <= ε2
                continue  # no end of a line, try again
            end
        end
        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(j_start - 1)
            D2_line = zero(T) # verbesserung: zero(T) ?!
            for k in 1:dim
                D2_line += (x[i_start - offset,k] - x[j_start - offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end
        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)
            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0
            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples
                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2
                push!(det_history, det_val)
                push!(l_history,   l_val)
                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end] # Verbesserung: @view added better?!?
                    l_window   = l_history[end-W+1:end]
                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end          
    end

    countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
    return L_local, countAll_correct_scaled
end


"""
    Sampling 4.1: hybrid 
                (norbert for periodic or stratified- + memory + importance sampling with LFboth (optimized) for Drift, Noise and Chaotic) determined by xxxx value (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    xxxx
"""

function smi_LFboth_or_norbert_rand_with_LineLength_LFboth_condition(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Float64, N)           # Histogram for line lengths - mit typ float64, wegen korrektur in zählung der linien bestimmter länge (1/cnt)
    # L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    


    if s !== nothing
        actual_s = s
    elseif auto_s
        estimated_RR = estimate_RR(x, ε)

        if estimated_RR < 0.05
            # SEHR DÜNNES RP (z.B. Rössler): 
            # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
            # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
            actual_s = 5.0   
            estimated_tries_per_box = 50
            
        elseif estimated_RR > 0.2
            # SEHR DICHTES RP (z.B. Rauschen): 
            # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
            # um Overhead zu sparen.
            actual_s = 0.5   
            estimated_tries_per_box = 12
            
        else
            # NORMALFALL (estimated_RR zwischen 0.05 und 0.2 (mittel ca. 0.1)):
            actual_s = 1.0   
            estimated_tries_per_box = 24
        end

    else
        actual_s = 1.0
        estimated_tries_per_box = 24
    end
    
    s_tilde = M * actual_s
    # box_length_dyn = 4000
    # print(box_length_dyn)
    num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    box_length_dyn = total_pairs ÷ num_boxes
    current_box = 0
    
    active_boxs = Int[]
    check_cnt = 0 # black points checked for being part of a line of at least length of 50 (dynamisch besser?!)
    check_cnt_max = 20 # dynamisch besser !?
    check_length = clamp(N ÷ 10, 20, 100) # dynamisch besser !? -> !!
    LFboth_check_length = check_length ÷ 2
    long_lines_goal = 3 # dynamisch besser !?
    is_periodic = false
    long_lines = 0
    d1 = -1 # d1, d2, d3 are the diagonals of the found long lines (to avoid counting the same line multiple times)
    d2 = -1
    d3 = -1

    for current_box in 1:num_boxes
        for _ in 1:estimated_tries_per_box # konstante anzahl an versuchen (z.B.: 10) pro box? oder dynamisch (wharshcienlichkeit weiß zu treffen nach der estimated_RR bei 7.7 (siehe oben))?
            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
            
            d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  
            else
                push!(active_boxs, current_box)
                if check_periodicity && check_cnt < check_cnt_max
                    check_cnt += 1
                    
                    max_possible_offset = N - max(i_start, j_start) # max abstadn zu rändern
                    if max_possible_offset < check_length

                    else
                        is_long_line_following = true
                        is_long_line_prev = true
                        # Black Point found, estimate periodicity
                        @inbounds for offset in 0:min(LFboth_check_length, (N - i_start)) 
                            D2_line_following = zero(T) # verbesserung: zero(T) ?!
                            @inbounds for k in 1:dim
                                D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                            end
                            if D2_line_following > ε2          # Count points belonging to diagonal
                                is_long_line_following = false
                                break                 # Line ends
                            end
                        end
                        @inbounds for offset in 1:min(LFboth_check_length, (j_start-1)) 
                            D2_line_prev = zero(T) # verbesserung: zero(T) ?!
                            @inbounds for k in 1:dim
                                D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
                            end
                            if D2_line_prev > ε2          # Count points belonging to diagonal
                                is_long_line_prev = false
                                break                 # Line ends
                            end
                        end
                        if is_long_line_following && is_long_line_prev
                            if d != d1 && d != d2 && d != d3
                                long_lines += 1
                                if long_lines == 1
                                    d1 = d
                                elseif long_lines == 2
                                    d2 = d
                                elseif long_lines == 3
                                    d3 = d    
                                end
                            end
                        end
                    end    
                end
                break # raus aus der current box falls schwarzen punkt gefunden
            end
        end
        if long_lines >= long_lines_goal # && check_periodicity
            is_periodic = true
            break
        end
    end


    if is_periodic
        while count < M
            countAll += 1                 # Count number of searches
            idx = rand(1:total_pairs)     # Random start pair (i,j) in linear notation
            i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
            j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

            #println("i: ", i_start, "  j: ", j_start)

            # Check if R(i_start,j_start) = 1 (start point)
            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein Linienstart, nächster Versuch
            end

            # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
            if i_start == 1 || j_start == 1
                # We are at the lower border – no previous points
            else
                D2_prev = zero(T)
                @inbounds for k in 1:dim
                    D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
                end
                if D2_prev <= ε2
                    continue  # no begin of a line, try again
                end
            end

            # Line found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start)
                D2_line = zero(T)
                @inbounds for k in 1:dim
                    D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end

            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                L_local[cnt] += 1         # Store completed line length
                count += 1                # Count found lines (only counted if a line was found)

                sum_n_L  += cnt
                sum_n2_L += cnt >= 2 ? cnt : 0
                sum_L2   += cnt >= 2 ? 1  : 0



                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples

                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2

                    push!(det_history, det_val)
                    push!(l_history,   l_val)


                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end]
                        l_window   = l_history[end-W+1:end]

                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end
        end
        return L_local, countAll
    else
        current_box = 0
        while count < M

            current_box = rand(active_boxs) 
            #if current_box > num_boxes
            #    current_box = 1
            #end

            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            countAll += 1                 # Count number of searches
            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation

            # weshalb das folgende? mathe verstehen.
            d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d                 # zeile größer spalte => oberes dreieck (diagonale von links unten nach rechts oben und achsen-nullpunkt links unten)

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein schwarzer Punkt, nächster Versuch
            end

            # Black Point found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start) # weshalb klappt das?
                D2_line_following = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line_following <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
                D2_line_prev = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
                end
                if D2_line_prev <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                weight = 1/cnt
                L_local[cnt] += weight         # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
                count += 1                # Count found lines (only counted if a line was found)
                sum_n_L  += cnt * weight
                sum_n2_L += cnt >= 2 ? cnt*weight : 0.0
                sum_L2   += cnt >= 2 ? weight  : 0.0
                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples
                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2
                    push!(det_history, det_val)
                    push!(l_history,   l_val)
                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end] # verbesserung: @view added better?!?
                        l_window   = l_history[end-W+1:end]
                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end          
        end

        countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
        return L_local, countAll_correct_scaled

    end
end
    

"""
    Sampling 4.2: hybrid_periodtest_upwdlf_invented_parametervals (norbert for periodic or stratified- + memory + importance sampling with LFboth (optimized) for Drift, Noise and Chaotic) determined by xxxx value (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    smi_LFboth or norbert rand with condition für is_periodic or not, that in the row in the upper triangle, die als letzte, 
    nach oben gezählt noch mindestens (i = N-check_length bedeutet, dass auf der y-achse noch check_length über bleibt. Demnach bleibt in der diagonalen, nahc pythagoras, noch mehr als check_length) eine diagonale von der länge check_length zulässt, alle spalten bis zut LOI durchgegangen werden von
     links nach rechts und das heißt alle diagonalen, so dass jeder schwarze punkt nach oben rechts verfolgt wird und falls länge check 
     length erfüllt wird diese diagonale gespeichert, bis drei gespeichert sind oder eine spalte vor LOI erreicht und geprüft ist. falls drei (bis fünf) diags gefunden, 
     dann äquidistanz prüfen (puffer für falsche diagonalen aus rauschen oder und chaos werden durch puffer kompensiert, so dass maximal fünf diagonale geprüft 
     werden (basierend auf statistischen aussagen von gemini, dass mehr als zwei falsche diagonale in einem periodischen system ausreichend unwahrscheinlich sind))
     Außerdem max_misses am stück beim diagonale verfolgen 
     (smi_LFboth_or_norbert_rand_with_LineLength_forward_condition)
    
    die 1 ist forward line following in der periodizitätsprüfung, dann dep ist dependency selbstüberlegt der parameter, abs sind abolute selbstüberlegte werte, fft oder andere sind die vorabschätzungen und womf oder kein womf ist without max fails oder mit
     
    deps durch beobachtung/statistik/erfahrung
    """

function hybrid1_dep(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Float64, N)           # Histogram for line lengths - mit typ float64, wegen korrektur in zählung der linien bestimmter länge (1/cnt)
    # L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    # check periodicity by checking diagonals for black points (by going through the columns of the 2N÷3 th row <=> 2/3 of the diagonals are checked) and suffieciently equidistant periodic distances in between them and if so, then the line length is checked for sufficent length (dynamically determined conditions (sufficient length, fraction of the matrix/RP that is getting checked )? and absolute conditions (sufficient number of black diagonals, error in equidistance of the potential period in between the black diagonals)?)
    check_length = clamp(N ÷ 20, 15, 100) # dynamisch besser !? -> !! und max besser als clamp?? gefhar auf unnötig lange prüfungen?
    max_misses = 3 # max weiße punkte am stück bei linienverfolgung, bevor abgebrochen wird. absolut ist am, besten?
    is_periodic = false
    long_lines = 0
    d1 = -1 # -1 heißt einfach noch keine reale diagonale zugewiesen; diagonalen-ID ist immer d > 0 , außer LOI d=0
    d2 = -1
    d3 = -1
    d4 = -1
    d5 = -1
    i = N - check_length # oberste zeile, die noch eine diagonale von länge check_length im upper_triangle zulässt
                        # eig doch digonal check_length nur benötigt, also i = N - (a=\sqrt(check_length**2 - c**2)) ?? aber wir wollen keine wurzeln, also reicht uns N-check_length??
    min_period_length = 3            # drift nahe LOI oder ähnliche einfach schwarze masseneffekte nicht als periodisch anerkennen
    max_fails = clamp(N ÷ 20, 50, 300)    # Schneller Abbruch bei White Noise, noise früh erkennen und nicht ewig auf periodizität prüfen
    failed_lines = 0    # wegen ?zähler? 0 und nicht zero(T) ?!?
    period_equidistance_error = 2 # maximal erlaubter fehler in der äquidistanz der abstände/perioden zwischen den aktuell geprüften diagonalen

    @inbounds for j in 1:(i-1)
        misses = 0 # wegen ?zähler? 0 und nicht zero(T) ?!?
        if failed_lines >= max_fails
            break
        end
        D2_point_in_i = zero(T)
        @inbounds for k in 1:dim
            D2_point_in_i += (x[i,k] - x[j,k])^2
        end 
        if D2_point_in_i <= ε2  # point in row i and therefore diagonal d is black => line following (up)
            is_long_line = true
            @inbounds for offset in 1:check_length
                D2_line_following = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_following += (x[i + offset,k] - x[j + offset,k])^2
                end
                if D2_line_following > ε2          # line is shorter than check_length
                    misses += 1
                    if misses >= max_misses
                        is_long_line = false
                        failed_lines += 1
                        break
                    end
                else
                    misses = 0
                end
            end
            if is_long_line                                   # for loop ist durchgelaufen ohne break => line has at least check_length
                d = i - j
                if long_lines == 0
                    long_lines += 1
                    d1 = d
                elseif long_lines == 1
                    long_lines += 1
                    d2 = d
                elseif long_lines == 2
                    long_lines += 1
                    d3 = d
                    if abs((d1-d2)-(d2-d3)) <= period_equidistance_error && min((d1-d2), (d2-d3)) >= min_period_length         # check for equidistance (constant period (with maximum error of two pixels and minimum period_length)) in bewtween diagonals 
                        is_periodic = true
                        break
                    end
                elseif long_lines == 3
                    long_lines += 1
                    d4 = d
                    if (abs((d1-d2)-(d2-d4)) <= period_equidistance_error && min(d1-d2, d2-d4) >= min_period_length) || 
                       (abs((d1-d3)-(d3-d4)) <= period_equidistance_error && min(d1-d3, d3-d4) >= min_period_length) || 
                       (abs((d2-d3)-(d3-d4)) <= period_equidistance_error && min(d2-d3, d3-d4) >= min_period_length) 
                        is_periodic = true
                        break
                    end
                elseif long_lines == 4
                    long_lines += 1
                    d5 = d
                    if (abs((d1-d2)-(d2-d5)) <= period_equidistance_error && min((d1-d2), (d2-d5)) >= min_period_length) || 
                        (abs((d1-d3)-(d3-d5)) <= period_equidistance_error && min((d1-d3), (d3-d5)) >= min_period_length) ||
                        (abs((d1-d4)-(d4-d5)) <= period_equidistance_error && min((d1-d4), (d4-d5)) >= min_period_length) || 
                        (abs((d2-d3)-(d3-d5)) <= period_equidistance_error && min((d2-d3), (d3-d5)) >= min_period_length) || 
                        (abs((d2-d4)-(d4-d5)) <= period_equidistance_error && min((d2-d4), (d4-d5)) >= min_period_length) || 
                        (abs((d3-d4)-(d4-d5)) <= period_equidistance_error && min((d3-d4), (d4-d5)) >= min_period_length)          # check for equidistance (constant period (with maximum error of two pixels)) in bewtween diagonals 
                        is_periodic = true
                        break
                    end
                end
            end
        end
    end 


    if is_periodic
        
        # println("--> NORBERTS SAMPLING (DETECTED AS PERIODIC)")
        while count < M
            countAll += 1                 # Count number of searches
            idx = rand(1:total_pairs)     # Random start pair (i,j) in linear notation
            i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
            j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

            #println("i: ", i_start, "  j: ", j_start)

            # Check if R(i_start,j_start) = 1 (start point)
            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein Linienstart, nächster Versuch
            end

            # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
            if i_start == 1 || j_start == 1
                # We are at the lower border – no previous points
            else
                D2_prev = zero(T)
                @inbounds for k in 1:dim
                    D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
                end
                if D2_prev <= ε2
                    continue  # no begin of a line, try again
                end
            end

            # Line found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start)
                D2_line = zero(T)
                @inbounds for k in 1:dim
                    D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end

            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                L_local[cnt] += 1         # Store completed line length
                count += 1                # Count found lines (only counted if a line was found)

                sum_n_L  += cnt
                sum_n2_L += cnt >= 2 ? cnt : 0
                sum_L2   += cnt >= 2 ? 1  : 0



                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples

                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2

                    push!(det_history, det_val)
                    push!(l_history,   l_val)


                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end]
                        l_window   = l_history[end-W+1:end]

                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end
        end
        return L_local, countAll

    else
    
    
        if s !== nothing
            actual_s = s
        elseif auto_s
            estimated_RR = estimate_RR(x, ε)

            if estimated_RR < 0.05
                # SEHR DÜNNES RP (z.B. Rössler): 
                # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
                # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
                actual_s = 5.0   
                estimated_tries_per_box = 50

            elseif estimated_RR > 0.2
                # SEHR DICHTES RP (z.B. Rauschen): 
                # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
                # um Overhead zu sparen.
                actual_s = 0.5   
                estimated_tries_per_box = 12

            else
                # NORMALFALL (estimated_RR zwischen 0.05 und 0.2 (mittel ca. 0.1)):
                actual_s = 1.0   
                estimated_tries_per_box = 24
            end

        else
            actual_s = 1.0
            estimated_tries_per_box = 24
        end

        s_tilde = M * actual_s
        # box_length_dyn = 4000
        # print(box_length_dyn)
        num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
        box_length_dyn = total_pairs ÷ num_boxes
        current_box = 0
        active_boxs = Int[]

        for current_box in 1:num_boxes
            for _ in 1:estimated_tries_per_box # konstante anzahl an versuchen (z.B.: 10) pro box? oder dynamisch (wharshcienlichkeit weiß zu treffen nach der estimated_RR bei 7.7 (siehe oben))?
                lower_bound = (current_box-1) * box_length_dyn + 1
                upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

                idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation

                d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
                previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
                j_start = idx - previous_elements     # spalte
                i_start = j_start + d

                D2 = zero(T)
                @inbounds for k in 1:dim
                    D2 += (x[i_start,k] - x[j_start,k])^2
                end
                if D2 > ε2
                    continue  
                else
                    push!(active_boxs, current_box)
                    break # raus aus der current box falls schwarzen punkt gefunden
                end
            end
        end


        current_box = 0
        while count < M

            current_box = rand(active_boxs) 
            #if current_box > num_boxes
            #    current_box = 1
            #end

            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            countAll += 1                 # Count number of searches
            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation

            # weshalb das folgende? mathe verstehen.
            d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d                 # zeile größer spalte => oberes dreieck (diagonale von links unten nach rechts oben und achsen-nullpunkt links unten)

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein schwarzer Punkt, nächster Versuch
            end

            # Black Point found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start) # weshalb klappt das?
                D2_line_following = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line_following <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
                D2_line_prev = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
                end
                if D2_line_prev <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                weight = 1/cnt
                L_local[cnt] += weight         # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
                count += 1                # Count found lines (only counted if a line was found)
                sum_n_L  += cnt * weight
                sum_n2_L += cnt >= 2 ? cnt*weight : 0.0
                sum_L2   += cnt >= 2 ? weight  : 0.0
                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples
                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2
                    push!(det_history, det_val)
                    push!(l_history,   l_val)
                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end] # verbesserung: @view added better?!?
                        l_window   = l_history[end-W+1:end]
                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end          
        end

        countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
        return L_local, countAll_correct_scaled

    end
end
    



"""
Sampling 4.2.1: hybrid1_dep ohne max_fails (und andere deps?)
"""

function hybrid1_dep_womf(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true, true_line_test::Bool = false) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Float64, N)           # Histogram for line lengths - mit typ float64, wegen korrektur in zählung der linien bestimmter länge (1/cnt)
    # L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    # check periodicity by checking diagonals for black points (by going through the columns of the 2N÷3 th row <=> 2/3 of the diagonals are checked) and suffieciently equidistant periodic distances in between them and if so, then the line length is checked for sufficent length (dynamically determined conditions (sufficient length, fraction of the matrix/RP that is getting checked )? and absolute conditions (sufficient number of black diagonals, error in equidistance of the potential period in between the black diagonals)?)
    check_length = clamp(N ÷ 20, 15, 100) # dynamisch besser !? -> !! und max besser als clamp?? gefhar auf unnötig lange prüfungen?
    max_misses = 3 # max weiße punkte am stück bei linienverfolgung, bevor abgebrochen wird. absolut ist am, besten?
    is_periodic = false
    long_lines = 0
    d1 = d2 = d3 = d4 = d5 = -1 # -1 heißt einfach noch keine reale diagonale zugewiesen; diagonalen-ID ist immer d > 0 , außer LOI d=0
    i = N - check_length # oberste zeile, die noch eine diagonale von länge check_length im upper_triangle zulässt
                        # eig doch digonal check_length nur benötigt, also i = N - (a=\sqrt(check_length**2 - c**2)) ?? aber wir wollen keine wurzeln, also reicht uns N-check_length??
    W = clamp(N ÷ 50, 15, 100)           # drift nahe LOI oder ähnliche einfach schwarze masseneffekte (theiler window, soujorn/verweil zeit) nicht berücksichtigen
    period_equidistance_error = 2 # maximal erlaubter fehler in der äquidistanz der abstände/perioden zwischen den aktuell geprüften diagonalen
    current = 1 # aktuelle spalte in zeile i

    @inbounds while current <= (i-1)
        misses = 0 # wegen ?zähler? 0 und nicht zero(T) ?!?
        D2_point_in_i = zero(T)
        @inbounds for k in 1:dim
            D2_point_in_i += (x[i,k] - x[current,k])^2
        end 
        if D2_point_in_i <= ε2  # point in row i and therefore diagonal d is black => line following (up)
            is_long_line = true
            @inbounds for offset in 1:check_length
                D2_line_following = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_following += (x[i + offset,k] - x[current + offset,k])^2
                end
                if D2_line_following > ε2          # line is shorter than check_length
                    misses += 1
                    if misses >= max_misses
                        is_long_line = false
                        break
                    end
                else
                    misses = 0
                end
            end
            if is_long_line                                   # for loop ist durchgelaufen ohne break => line has at least check_length
                d = i - current
                if long_lines == 0
                    long_lines += 1
                    d1 = d
                    current += W
                elseif long_lines == 1
                    long_lines += 1
                    d2 = d
                    current += W
                elseif long_lines == 2
                    long_lines += 1
                    d3 = d
                    current += W
                    if abs((d1-d2)-(d2-d3)) <= period_equidistance_error         # check for equidistance (constant period (with maximum error of two pixels and minimum period_length)) in bewtween diagonals 
                        is_periodic = true
                        break
                    end
                elseif long_lines == 3
                    long_lines += 1
                    d4 = d
                    current += W
                    if (abs((d1-d2)-(d2-d4)) <= period_equidistance_error )|| 
                       (abs((d1-d3)-(d3-d4)) <= period_equidistance_error )|| 
                       (abs((d2-d3)-(d3-d4)) <= period_equidistance_error )
                        is_periodic = true
                        break
                    end
                elseif long_lines == 4
                    long_lines += 1
                    d5 = d
                    current += W
                    if (abs((d1-d2)-(d2-d5)) <= period_equidistance_error )|| 
                        (abs((d1-d3)-(d3-d5)) <= period_equidistance_error) ||
                        (abs((d1-d4)-(d4-d5)) <= period_equidistance_error) || 
                        (abs((d2-d3)-(d3-d5)) <= period_equidistance_error) || 
                        (abs((d2-d4)-(d4-d5)) <= period_equidistance_error) || 
                        (abs((d3-d4)-(d4-d5)) <= period_equidistance_error)          # check for equidistance (constant period (with maximum error of two pixels)) in bewtween diagonals 
                        is_periodic = true
                        break
                    else
                        break # max 5 diagonals checked, if not periodic, then break
                    end
                end
            else
                current += 1 # shcwarzer punkt, aber keine lange diagonale
            end
        else
            current += 1 # weißer pixel
        end
    end 


    if is_periodic
        
        # println("--> NORBERTS SAMPLING (DETECTED AS PERIODIC)")
        while count < M
            countAll += 1                 # Count number of searches
            idx = rand(1:total_pairs)     # Random start pair (i,j) in linear notation
            i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
            j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

            #println("i: ", i_start, "  j: ", j_start)

            # Check if R(i_start,j_start) = 1 (start point)
            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein Linienstart, nächster Versuch
            end

            # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
            if i_start == 1 || j_start == 1
                # We are at the lower border – no previous points
            else
                D2_prev = zero(T)
                @inbounds for k in 1:dim
                    D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
                end
                if D2_prev <= ε2
                    continue  # no begin of a line, try again
                end
            end

            # Line found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start)
                D2_line = zero(T)
                @inbounds for k in 1:dim
                    D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end

            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                L_local[cnt] += 1         # Store completed line length
                count += 1                # Count found lines (only counted if a line was found)

                sum_n_L  += cnt
                sum_n2_L += cnt >= 2 ? cnt : 0
                sum_L2   += cnt >= 2 ? 1  : 0



                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples

                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2

                    push!(det_history, det_val)
                    push!(l_history,   l_val)


                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end]
                        l_window   = l_history[end-W+1:end]

                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end
        end
        return L_local, countAll

    else
    
    
        if s !== nothing
            actual_s = s
        elseif auto_s
            estimated_RR = estimate_RR(x, ε)

            if estimated_RR < 0.05
                # SEHR DÜNNES RP (z.B. Rössler): 
                # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
                # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
                actual_s = 5.0   
                estimated_tries_per_box = 50

            elseif estimated_RR > 0.2
                # SEHR DICHTES RP (z.B. Rauschen): 
                # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
                # um Overhead zu sparen.
                actual_s = 0.5   
                estimated_tries_per_box = 12

            else
                # NORMALFALL (estimated_RR zwischen 0.05 und 0.2 (mittel ca. 0.1)):
                actual_s = 1.0   
                estimated_tries_per_box = 24
            end

        else
            actual_s = 1.0
            estimated_tries_per_box = 24
        end

        s_tilde = M * actual_s
        # box_length_dyn = 4000
        # print(box_length_dyn)
        num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
        box_length_dyn = total_pairs ÷ num_boxes
        current_box = 0
        active_boxs = Int[]

        for current_box in 1:num_boxes
            for _ in 1:estimated_tries_per_box # konstante anzahl an versuchen (z.B.: 10) pro box? oder dynamisch (wharshcienlichkeit weiß zu treffen nach der estimated_RR bei 7.7 (siehe oben))?
                lower_bound = (current_box-1) * box_length_dyn + 1
                upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

                idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation

                d = ceil(Int, ((2.0 * N - 1) - sqrt(Float64((2.0 * N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
                previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
                j_start = idx - previous_elements     # spalte
                i_start = j_start + d

                D2 = zero(T)
                @inbounds for k in 1:dim
                    D2 += (x[i_start,k] - x[j_start,k])^2
                end
                if D2 > ε2
                    continue  
                else
                    push!(active_boxs, current_box)
                    break # raus aus der current box falls schwarzen punkt gefunden
                end
            end
        end


        current_box = 0
        while count < M

            current_box = rand(active_boxs) 
            #if current_box > num_boxes
            #    current_box = 1
            #end

            lower_bound = (current_box-1) * box_length_dyn + 1
            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn

            countAll += 1                 # Count number of searches
            idx = rand(lower_bound:upper_bound)     # Random start pair (i,j) in linear notation

            # weshalb das folgende? mathe verstehen.
            d = ceil(Int, ((2N - 1) - sqrt(Float64((2N - 1)^2 - 8 * idx))) / 2) # which diagonal we are on
            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
            j_start = idx - previous_elements     # spalte
            i_start = j_start + d                 # zeile größer spalte => oberes dreieck (diagonale von links unten nach rechts oben und achsen-nullpunkt links unten)

            D2 = zero(T)
            @inbounds for k in 1:dim
                D2 += (x[i_start,k] - x[j_start,k])^2
            end
            if D2 > ε2
                continue  # kein schwarzer Punkt, nächster Versuch
            end

            # Black Point found, now count line length
            cnt = 0
            @inbounds for offset in 0:(N - i_start) # weshalb klappt das?
                D2_line_following = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                end
                if D2_line_following <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
                D2_line_prev = zero(T) # verbesserung: zero(T) ?!
                @inbounds for k in 1:dim
                    D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
                end
                if D2_line_prev <= ε2          # Count points belonging to diagonal
                    cnt += 1              # Extend diagonal
                else
                    break                 # Line ends
                end
            end
            # Store line length to histogram variable
            if cnt > 0 #&& !((i_start, j_start) in seen)
                weight = 1/cnt
                L_local[cnt] += weight         # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
                count += 1                # Count found lines (only counted if a line was found)
                sum_n_L  += cnt * weight
                sum_n2_L += cnt >= 2 ? cnt*weight : 0.0
                sum_L2   += cnt >= 2 ? weight  : 0.0
                # im Loop, nach count += 1:
                if count % K == 0 && count >= min_samples
                    # DET und L direkt aus den Summen:
                    det_val = sum_n2_L / sum_n_L
                    l_val   = sum_n2_L / sum_L2
                    push!(det_history, det_val)
                    push!(l_history,   l_val)
                    if length(det_history) >= W
                        # relative change over last window
                        det_window = det_history[end-W+1:end] # verbesserung: @view added better?!?
                        l_window   = l_history[end-W+1:end]
                        rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                        rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)
                        # Break if difference is not changing for last K iterations
                        if rel_det < tol && rel_l < tol
                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                            break
                        end
                    end
                end
            end          
        end

        countAll_correct_scaled = round(Int, countAll * (num_boxes / length(active_boxs)))
        return L_local, countAll_correct_scaled

    end
end




"""
Sampling 4.2.1.1: hybrid1_dep ohne max_fails (und andere deps?) wnlfb
"""
function hybrid1_dep_wnlfb(x::AbstractVector{<:SVector}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, epsilon_quantile::Bool = false, rng::AbstractRNG = Random.default_rng()) where {T<:AbstractFloat}
    N = length(x)                  
    
    # Optionales Umschalten zwischen absolutem Epsilon und Quantil-Epsilon
    if epsilon_quantile == true
        target_rr = 0.03  # laut literatur zwischen 2 und 5% für alle systeme??
        ε2 = estimate_epsilon_sq_by_rr(rng, x, target_rr, samples=100000)
        ε = sqrt(ε2) # Nur für Metriken oder Logging, falls das lineare Epsilon benötigt wird
    else
        ε2 = ε^2 # Fallback auf statisches Epsilon
    end
    
    # 1. Periodizitäts-Parameter vorbereiten
    check_length = clamp(N ÷ 20, 15, 100) 
    max_misses = 3 
    period_equidistance_error = 2 
    W_theiler = estimate_W(rng, x, ε) 
    W_soujorn = max(3, W_theiler)           
    
    estimated_RR = estimate_RR_svec(rng, x, ε)
    max_fails = clamp(round(Int, 3.0 / max(estimated_RR, 0.01)), 15, 150)
   
    # 2. Aufruf der externen Logik-Funktion
    is_periodic = check_periodicity_block(x, N, check_length, max_misses, period_equidistance_error, W_soujorn, max_fails, ε2)

    # 3. Dispatch (Maximal 5-6 Argumente -> bleibt zu 100% in den CPU-Registern!)
    if is_periodic
        return rand_sample_lfb_svec(rng, x, ε2, M, W_theiler, W_soujorn)
    else
        return smi_lfb_svec(rng, x, ε2, M, estimated_RR, s, W_theiler, W_soujorn)
    end
end





#function hybrid1_dep_wnlfb(x::AbstractVector{<:SVector}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, rng::AbstractRNG = Random.default_rng()) where {T<:AbstractFloat}
#    N = length(x)                  
#    L_local = zeros(Float64, N)           
#    ε2 = ε^2                          
#    count = 0                         
#    countAll = 0                      
#    total_pairs = N * (N - 1) >> 1     # >> 1 ist Lichtgeschwindigkeit verglichen mit ÷ 2
#
#    max_searches = max(M * 200, total_pairs << 1) # << 1 bedeutet * 2 (Bitshift)
#
#    # Konvergenz-Konstanten aus der Schleife gezogen!
#    K = 50              
#    W_conv = 5               
#    tol = 1e-3          
#    min_samples = 500   
#
#    # High-Performance Float Konstanten für Stratified Sampling vorab berechnet
#    N_const = 2.0 * N - 1.0
#    N_const_sq = N_const^2
#    
#    det_ring = zeros(Float64, W_conv)
#    l_ring   = zeros(Float64, W_conv)
#    ring_idx = 1
#    history_count = 0
#
#    sum_n2_L = 0.0   
#    sum_L2   = 0.0   
#    
#    # Periodizitäts-Parameter vorbereiten
#    check_length = clamp(N ÷ 20, 15, 100) 
#    max_misses = 3 
#    period_equidistance_error = 2 
#    W_theiler = estimate_W(rng, x, ε) 
#    W_soujorn = max(3, W_theiler)           
#    
#    estimated_RR = estimate_RR_svec(rng, x, ε)
#    max_fails = clamp(round(Int, 3.0 / max(estimated_RR, 0.01)), 15, 150)
#   
#    # Aufruf der extrem kompakten, ausgelagerten Logik-Funktion
#    is_periodic = check_periodicity_block(x, N, check_length, max_misses, period_equidistance_error, W_soujorn, max_fails, ε2)
#
#    if is_periodic
#        # -------------------------------------------------------------
#        # BRANCH A: PERIODIC (Uniform Random) - NULL Wurzeln!
#        # -------------------------------------------------------------
#
#        
#    else
#        # -------------------------------------------------------------
#        # BRANCH B: STRATIFIED (Boxed) - Float-Hardware Ausnutzung!
#        # -------------------------------------------------------------
#        
#    end
#end




#function hybrid1_dep_wnlfb(x::AbstractVector{<:SVector}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, rng::AbstractRNG = Random.default_rng()) where {T<:AbstractFloat}
#    N = length(x)                  # Number of observations and variables
#    L_local = zeros(Float64, N)           # Histogram for line lengths - mit typ float64, wegen korrektur in zählung der linien bestimmter länge (1/cnt)
#    # L_local_old = zeros(Int, N)       # Histogram for line lengths
#    ε2 = ε^2                          # Squared threshold (avoids sqrt)
#    count = 0                         # Number of valid lines found
#    countAll = 0                      # Number of searches
#    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)
#
#    max_searches = max(M * 200, total_pairs * 2)
#
#    # Convergenz parameter
#    K = 50              # newly calculate all K lines
#    W_conv = 5               # window size for sliding average
#    tol = 1e-3          # relative toleranz
#    min_samples = 500   # minimum number of samples before break
#
#    N_const = 2N - 1
#    N_const_sq = N_const^2
#
#    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
#    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
#    sum_L2   = 0.0   # sum(L[n]) for n >= 2
#    
#    det_ring = zeros(Float64, W_conv)
#    l_ring   = zeros(Float64, W_conv)
#    ring_idx = 1
#    history_count = 0
#
#    # check periodicity by checking diagonals for black points (by going through the columns of the 2N÷3 th row <=> 2/3 of the diagonals are checked) and suffieciently equidistant periodic distances in between them and if so, then the line length is checked for sufficent length (dynamically determined conditions (sufficient length, fraction of the matrix/RP that is getting checked )? and absolute conditions (sufficient number of black diagonals, error in equidistance of the potential period in between the black diagonals)?)
#    check_length = clamp(N ÷ 20, 15, 100) # dynamisch besser !? -> !! und max besser als clamp?? gefhar auf unnötig lange prüfungen?
#    max_misses = 3 # max weiße punkte am stück bei linienverfolgung, bevor abgebrochen wird. absolut ist am, besten?
#    is_periodic = false
#    long_lines = 0
#    d1 = d2 = d3 = d4 = d5 = -1 # -1 heißt einfach noch keine reale diagonale zugewiesen; diagonalen-ID ist immer d > 0 , außer LOI d=0
#    d12 = d23 = d34 = d45 = d13 = d24 = d14 = d15 = d25 = d35 = 0 # globaler definieren und speichern, dass sie nicht nur in den if blöcken existieren und dann wieder gelöscht werden siehe unten
#    i = N - check_length # oberste zeile, die noch eine diagonale von länge check_length im upper_triangle zulässt
#                        # eig doch digonal check_length nur benötigt, also i = N - (a=\sqrt(check_length**2 - c**2)) ?? aber wir wollen keine wurzeln, also reicht uns N-check_length??
#    period_equidistance_error = 2 # maximal erlaubter fehler in der äquidistanz der abstände/perioden zwischen den aktuell geprüften diagonalen
#    W_theiler = estimate_W(rng, x, ε) # Theiler-Window
#    current = i - W_theiler # aktuelle spalte in zeile i
#    W_soujorn = max(3, W_theiler)           # pause_after_long_diag; drift nahe LOI oder ähnliche einfach schwarze masseneffekte (theiler window, soujorn/verweil zeit) nicht berücksichtigen
#    estimated_RR = estimate_RR_svec(rng, x, ε)
#    # Bei hohem RR (viel Rauschen/Dichte) brechen wenige Fehlversuche das Verfahren ab (z.B. 20).
#    # Bei kleinem RR darf der Algorithmus mehr seltene schwarze Punkte testen (bis zu 150).
#    max_fails = clamp(round(Int, 3.0 / max(estimated_RR, 0.01)), 15, 150)
#    failed_attempts = 0
#   
#    @inbounds while current >= 1
#        if failed_attempts >= max_fails
#            break
#        end
#        
#        misses = 0 # wegen ?zähler? 0 und nicht zero(T) ?!?
#        if sq_dist(x, i, current) <= ε2  # point in row i and therefore diagonal d is black => line following (up)
#            is_long_line = true
#            @inbounds for offset in 1:check_length
#                if sq_dist(x, i+offset, current+offset) > ε2          # line is shorter than check_length
#                    misses += 1
#                    if misses >= max_misses
#                        is_long_line = false
#                        failed_attempts += 1
#                        break
#                    end
#                else
#                    misses = 0
#                end
#            end
#            if is_long_line                                   # for loop ist durchgelaufen ohne break => line has at least check_length
#                d = i - current
#                if long_lines == 0
#                    long_lines += 1
#                    d1 = d
#                    current -= W_soujorn
#                elseif long_lines == 1
#                    long_lines += 1
#                    d2 = d
#                    current -= W_soujorn
#                elseif long_lines == 2
#                    long_lines += 1
#                    d3 = d
#                    current -= W_soujorn
#                    d12 = d1 - d2
#                    d23 = d2 - d3
#
#                    if abs(d12-d23) <= period_equidistance_error         # check for equidistance (constant period (with maximum error of two pixels and minimum period_length)) in bewtween diagonals 
#                        is_periodic = true
#                        break
#                    end
#                elseif long_lines == 3
#                    long_lines += 1
#                    d4 = d
#                    current -= W_soujorn
#                    d34 = d3 - d4
#                    d24 = d2 - d4
#                    d13 = d1 - d3
#
#                    if (abs(d12-d24) <= period_equidistance_error )|| 
#                       (abs(d13-d34) <= period_equidistance_error )|| 
#                       (abs(d23-d34) <= period_equidistance_error )
#                        is_periodic = true
#                        break
#                    end
#                elseif long_lines == 4
#                    long_lines += 1
#                    d5 = d
#                    current -= W_soujorn
#                    d15 = d1 - d5
#                    d25 = d2 - d5
#                    d35 = d3 - d5
#                    d45 = d4 - d5
#
#                    if (abs(d12-d25) <= period_equidistance_error )|| 
#                        (abs(d13-d35) <= period_equidistance_error) ||
#                        (abs(d14-d45) <= period_equidistance_error) || 
#                        (abs(d23-d35) <= period_equidistance_error) || 
#                        (abs(d24-d45) <= period_equidistance_error) || 
#                        (abs(d34-d45) <= period_equidistance_error)          # check for equidistance (constant period (with maximum error of two pixels)) in bewtween diagonals 
#                        is_periodic = true
#                        break
#                    else
#                        break # max 5 diagonals checked, if not periodic, then break
#                    end
#                end
#            else
#                current -= 1 # shcwarzer punkt, aber keine lange diagonale
#            end
#        else
#            current -= 1 # weißer pixel
#        end
#    end 
#
#
#    if is_periodic
#        
#        # println("--> NORBERTS SAMPLING (wlfb) (DETECTED AS PERIODIC)")
#        while count < M
#
#            if countAll > max_searches
#                # Notausstieg: Das RP gibt nicht genug Linien für das geforderte M her.
#                break
#            end
#
#
#            countAll += 1                 # Count number of searches
#            # Alternativ: Direktes Ziehen der Diagonale d in 1:(N-1) und der Spalte j
#            # (spart sqrt vollständig ein):
#            # d = rand(rng, 1:(N-1))
#            # j_start = rand(rng, 1:(N - d))
#            # i_start = j_start + d
#
#            # Besser als oberes (Uniform Sampling, oberes ist nicht gleichverteilt?!?) ??:
#            u1 = rand(rng, 1:N)
#            u2 = rand(rng, 1:N)
#
#            if u1 == u2
#                continue  # Wir ignorieren die LOI
#            end
#
#            # i ist immer die größere Zahl, j die kleinere (Oberes Dreieck)
#            # minmax gibt das Tupel (kleinste, größte) zurück
#            j_start, i_start = minmax(u1, u2)
#
#            # 
#            if sq_dist(x, i_start, j_start) > ε2
#                continue  # kein schwarzer Punkt, nächster Versuch
#            end
#
#            # Black Point found, now count line length
#            cnt = 1 # einen haben wir ja schon gefunden
#            @inbounds for offset in 1:(N - i_start) # von eins, denn einen haben wir ja schon gefunden
#                if sq_dist(x, i_start + offset, j_start + offset) <= ε2          # Count points belonging to diagonal
#                    cnt += 1              # Extend diagonal
#                else
#                    break                 # Line ends
#                end
#            end
#            @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
#                if sq_dist(x, i_start - offset, j_start - offset) <= ε2          # Count points belonging to diagonal
#                    cnt += 1              # Extend diagonal
#                else
#                    break                 # Line ends
#                end
#            end
#            # Store line length to histogram variable
#            if cnt > 0 #&& !((i_start, j_start) in seen)
#
#                weight = 1.0 / cnt
#                L_local[cnt] += weight    # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
#                count += 1                # Count found lines (only counted if a line was found)
#
#                #sum_n2_L += cnt >= 2 ? 1.0 : 0.0
#                #sum_L2   += cnt >= 2 ? weight : 0.0
#                # besser, da if und ternäre operatoren einsparen, auf 1 und 0 abfragen reduzieren?!:
#                is_long = cnt >= 2
#                sum_n2_L += is_long
#                sum_L2   += is_long * weight
#
#                if count % K == 0 && count >= min_samples
#                    # DET und L direkt aus den Summen:
#                    det_val = sum_n2_L / count   # sum_n_L ist einfach count!
#                    l_val   = sum_n2_L / sum_L2
#                                    
#                    det_ring[ring_idx] = det_val
#                    l_ring[ring_idx]   = l_val
#                    ring_idx = (ring_idx % W_conv) + 1
#                    history_count += 1
#                    if history_count >= W_conv
#                        # relative change over last window
#                        det_window = det_ring
#                        l_window   = l_ring
#                        rel_det = calc_rel_change(det_window)
#                        rel_l   = calc_rel_change(l_window)
#                        # Break if difference is not changing for last K iterations
#                        if rel_det < tol && rel_l < tol
#                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
#                            break
#                        end
#                    end
#                end
#            end          
#        end
#
#        return L_local, countAll
#        
#
#    else
#    
#    
#        if s !== nothing
#            actual_s = s
#        elseif auto_s
#            
#
#            if estimated_RR < 0.05
#                # SEHR DÜNNES RP (z.B. Rössler): 
#                # Wir brauchen ein sehr feines Raster, um die schmalen Bänder nicht zu verfehlen.
#                # 5-mal so viele Boxen wie wir M suchen (winzige Boxen).
#                actual_s = 5.0   
#                estimated_tries_per_box = 50
#
#            elseif estimated_RR > 0.2
#                # SEHR DICHTES RP (z.B. Rauschen): 
#                # Die Trefferquote ist eh riesig, wir können die Boxen doppelt so groß machen,
#                # um Overhead zu sparen.
#                actual_s = 0.5   
#                estimated_tries_per_box = 12
#
#            else
#                # NORMALFALL (estimated_RR zwischen 0.05 und 0.2 (mittel ca. 0.1)):
#                actual_s = 1.0   
#                estimated_tries_per_box = 24
#            end
#
#        else
#            actual_s = 1.0
#            estimated_tries_per_box = 24
#        end
#
#        s_tilde = M * actual_s
#        # box_length_dyn = 4000
#        # print(box_length_dyn)
#        num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
#        box_length_dyn = total_pairs ÷ num_boxes
#        current_box = 0
#        active_boxs = Vector{Int}(undef, num_boxes)
#        active_box_count = 0
#
#        for current_box in 1:num_boxes
#            for _ in 1:estimated_tries_per_box # konstante anzahl an versuchen (z.B.: 10) pro box? oder dynamisch (wharshcienlichkeit weiß zu treffen nach der estimated_RR bei 7.7 (siehe oben))?
#                lower_bound = (current_box-1) * box_length_dyn + 1
#                upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn
#
#                idx = rand(rng, lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
#
#                # isqrt zieht die Wurzel auf reiner Integer-Basis (abgerundet)
#                # Durch den cleveren Trick mit der ganzzahligen Division (÷) eliminieren wir das ceil()
#                N_const = 2N - 1 # für riesen N, aber ohne rechenzeitverluste bei kleinen N?!
#                d = (N_const - isqrt(N_const_sq - 8 * idx) + 1) ÷ 2    # which diagonal we are on
#                previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
#                j_start = idx - previous_elements     # spalte
#                i_start = j_start + d
#
#                if sq_dist(x, i_start, j_start) > ε2
#                    continue  
#                else
#                    active_box_count += 1
#                    active_boxs[active_box_count] = current_box
#                    break # raus aus der current box falls schwarzen punkt gefunden
#                end
#            end
#        end
#
#        if active_box_count == 0
#            # println("No active boxes found. Returning early.")
#            return L_local, countAll # equivalent to an near empty RP
#        end
#
#        current_box = 0
#        while count < M
#            
#            if countAll > max_searches
#                # Notausstieg: Das RP gibt nicht genug Linien für das geforderte M her.
#                break
#            end
#
#
#            current_box = active_boxs[rand(rng, 1:active_box_count)] 
#            #if current_box > num_boxes
#            #    current_box = 1
#            #end
#
#            lower_bound = (current_box-1) * box_length_dyn + 1
#            upper_bound = current_box == num_boxes ? total_pairs : current_box * box_length_dyn
#
#            countAll += 1                 # Count number of searches
#            idx = rand(rng, lower_bound:upper_bound)     # Random start pair (i,j) in linear notation
#
#            # weshalb das folgende? mathe verstehen.
#            
#            d = (N_const - isqrt(N_const_sq - 8 * idx) + 1) ÷ 2    # which diagonal we are on ?(N_const - sqrt(N_const_sq - 8.0 * idx)) * 0.5)?
#            previous_elements = (d - 1) * N - (d - 1) * d ÷ 2
#            j_start = idx - previous_elements     # spalte
#            i_start = j_start + d                 # zeile größer spalte => oberes dreieck (diagonale von links unten nach rechts oben und achsen-nullpunkt links unten)
#
#            if sq_dist(x, i_start, j_start) > ε2
#                continue  # kein schwarzer Punkt, nächster Versuch
#            end
#
#            # Black Point found, now count line length
#            cnt = 1 # einen haben wir ja schon gefunden
#            @inbounds for offset in 1:(N - i_start) # einen haben wir ja schon gefunden
#                if sq_dist(x, i_start + offset, j_start + offset) <= ε2          # Count points belonging to diagonal
#                    cnt += 1              # Extend diagonal
#                else
#                    break                 # Line ends
#                end
#            end
#            @inbounds for offset in 1:(j_start-1) # weshalb klappt das?
#                if sq_dist(x, i_start - offset, j_start - offset) <= ε2          # Count points belonging to diagonal
#                    cnt += 1              # Extend diagonal
#                else
#                    break                 # Line ends
#                end
#            end
#            # Store line length to histogram variable
#            if cnt > 0 #&& !((i_start, j_start) in seen)
#                weight = 1/cnt
#                L_local[cnt] += weight         # Store completed line length w/ weight by line length so the count of lines is not biased by line-length
#                count += 1                # Count found lines (only counted if a line was found)
#                sum_n_L  += cnt * weight
#                sum_n2_L += cnt >= 2 ? cnt*weight : 0.0
#                sum_L2   += cnt >= 2 ? weight  : 0.0
#                # im Loop, nach count += 1:
#                if count % K == 0 && count >= min_samples
#                    # DET und L direkt aus den Summen:
#                    det_val = sum_n2_L / sum_n_L
#                    l_val   = sum_n2_L / sum_L2
#
#                    det_ring[ring_idx] = det_val
#                    l_ring[ring_idx]   = l_val
#                    ring_idx = (ring_idx % W_conv) + 1
#                    history_count += 1
#                    if history_count >= W_conv
#                        # relative change over last window
#                        det_window = det_ring
#                        l_window   = l_ring
#                        rel_det = calc_rel_change(det_window)
#                        rel_l   = calc_rel_change(l_window)
#                        # Break if difference is not changing for last K iterations
#                        if rel_det < tol && rel_l < tol
#                            # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
#                            break
#                        end
#                    end
#                end
#            end          
#        end
#
#        # Zuerst multiplizieren, dann ganzzahlig dividieren. Null Floating-Point-Ops!
#        countAll_correct_scaled = div(Int128(countAll) * num_boxes, active_box_count)
#        return L_local, countAll_correct_scaled
#
#    end
#end




"""
Sampling 4.3: hybrid1 mit vorabschätzung der parameter durch fft max misses, checklength, min period length, max fails, ?anzahl an zu findenden diags?, noch mehr parameter? oder womöglich neue noch dazu?
"""

function hybrid1_fft(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 4.3.1:
"""

function hybrid1_fft_womf(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 4.4: hybrid1 mit vorabschätzung der parameter durch ?xx? max misses, checklength, min period length, max fails, ?anzahl an zu findenden diags?, noch mehr parameter? oder womöglich neue noch dazu?
"""

function hybrid1_xx(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 4.4.1: 
"""

function hybrid1_xx_womf(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 4.5: hybrid1 mit absoluten werten der parameter durch beobachtung/statistik/erfahrung max misses, checklength, min period length, max fails, ?anzahl an zu findenden diags?, noch mehr parameter? oder womöglich neue noch dazu?
"""

function hybrid1_abs(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 4.5.1: 
"""

function hybrid1_abs_womf(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
    
end




"""
Sampling 5: QMC - sobol-sequenz - sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_qmc_sobol_sampled(x::AbstractMatrix{T}, ε::T, M::Int) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2

    sobol_gen = SobolSeq(1)
    skip(sobol_gen, 1)
    sobol_val = Vector{Float64}(undef, 1)
    
    while count < M
        countAll += 1                 # Count number of searches

        next!(sobol_gen, sobol_val)
        val = sobol_val[1]
        # val = next!(sobol_gen)[1]
        idx = floor(Int, val*total_pairs + 1)     # Random start pair (i,j) in linear notation
        idx = min(total_pairs, max(1, idx))
        i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
        j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

        #println("i: ", i_start, "  j: ", j_start)

        # Check if R(i_start,j_start) = 1 (start point)
        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end

        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = 0.0
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end

        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = 0.0
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end

        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)

            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0



            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples

                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2

                push!(det_history, det_val)
                push!(l_history,   l_val)


                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end]
                    l_window   = l_history[end-W+1:end]

                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end
    
    end

    return L_local, countAll
end

"""
Sampling 5.1: QMC - sobol-sequenz (buffer) - sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_qmc_sobol_buffer_sampled(x::AbstractMatrix{T}, ε::T, M::Int) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2

    sobol_gen = SobolSeq(1)
    skip(sobol_gen, 1)
    sobol_val = Vector{Float64}(undef, 1)

    # buffer
    buffer_size = 600000
    sobol_buffer = Vector{Float64}(undef, buffer_size)
    for i in 1:buffer_size
        next!(sobol_gen, sobol_val)
        sobol_buffer[i] = sobol_val[1]
    end

    buffer_idx = 1
    
    while count < M
        countAll += 1                 # Count number of searches

        if buffer_idx <= buffer_size
            val = sobol_buffer[buffer_idx]
            buffer_idx += 1
        else
            next!(sobol_gen, sobol_val)
            val = sobol_val[1]
        end
        # val = next!(sobol_gen)[1]

        idx = floor(Int, val*total_pairs + 1)     # Random start pair (i,j) in linear notation
        idx = min(total_pairs, max(1, idx))
        i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
        j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j

        #println("i: ", i_start, "  j: ", j_start)

        # Check if R(i_start,j_start) = 1 (start point)
        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end

        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = 0.0
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end

        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = 0.0
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end

        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)

            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0



            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples

                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2

                push!(det_history, det_val)
                push!(l_history,   l_val)


                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end]
                    l_window   = l_history[end-W+1:end]

                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end
    
    end

    return L_local, countAll
end

"""
Sampling 6: Importance (gewichtetes) - sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_importance_sampled(x::AbstractMatrix{T}, ε::T, M::Int) where {T<:AbstractFloat}
    N, dim = size(x)                  # Number of observations and variables
    L_local = zeros(Int, N)           # Histogram for line lengths
    L_local_old = zeros(Int, N)       # Histogram for line lengths
    ε2 = ε^2                          # Squared threshold (avoids sqrt)
    count = 0                         # Number of valid lines found
    countAll = 0                      # Number of searches
    total_pairs = N * (N - 1) ÷ 2     # Number of (i,j) paires with i > j (excl. LOI)

    det_history = Float64[]
    l_history   = Float64[]

    # Convergenz parameter
    K = 50              # newly calculate all K lines
    W = 5               # window size for sliding average
    tol = 1e-3          # relative toleranz
    min_samples = 500   # minimum number of samples before break

    sum_n_L  = 0.0   # sum(n * L[n]) for all n >= 1
    sum_n2_L = 0.0   # sum(n * L[n]) for n >= 2
    sum_L2   = 0.0   # sum(L[n]) for n >= 2
    
    while count < M
        countAll += 1                 # Count number of searches

        #if 
        #    estimated_RR 
        #end
        idx = floor(Int, val*total_pairs + 1)     # Random start pair (i,j) in linear notation
        idx = min(total_pairs, max(1, idx))
        i_start = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)     # Translate linear index to i
        j_start = idx - (i_start - 1) * (i_start - 2) ÷ 2  # Translate linear index to j
        
        #println("i: ", i_start, "  j: ", j_start)

        # Check if R(i_start,j_start) = 1 (start point)
        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i_start,k] - x[j_start,k])^2
        end
        if D2 > ε2
            continue  # kein Linienstart, nächster Versuch
        end

        # Check if preceeding point R(i_start-1, j_start-1) = 0 (beginning of a line)
        if i_start == 1 || j_start == 1
            # We are at the lower border – no previous points
        else
            D2_prev = 0.0
            @inbounds for k in 1:dim
                D2_prev += (x[i_start-1,k] - x[j_start-1,k])^2
            end
            if D2_prev <= ε2
                continue  # no begin of a line, try again
            end
        end

        # Line found, now count line length
        cnt = 0
        @inbounds for offset in 0:(N - i_start)
            D2_line = 0.0
            for k in 1:dim
                D2_line += (x[i_start + offset,k] - x[j_start + offset,k])^2
            end
            if D2_line <= ε2          # Count points belonging to diagonal
                cnt += 1              # Extend diagonal
            else
                break                 # Line ends
            end
        end

        # Store line length to histogram variable
        if cnt > 0 #&& !((i_start, j_start) in seen)
            L_local[cnt] += 1         # Store completed line length
            count += 1                # Count found lines (only counted if a line was found)

            sum_n_L  += cnt
            sum_n2_L += cnt >= 2 ? cnt : 0
            sum_L2   += cnt >= 2 ? 1  : 0



            # im Loop, nach count += 1:
            if count % K == 0 && count >= min_samples

                # DET und L direkt aus den Summen:
                det_val = sum_n2_L / sum_n_L
                l_val   = sum_n2_L / sum_L2

                push!(det_history, det_val)
                push!(l_history,   l_val)


                if length(det_history) >= W
                    # relative change over last window
                    det_window = det_history[end-W+1:end]
                    l_window   = l_history[end-W+1:end]

                    rel_det = (maximum(det_window) - minimum(det_window)) / mean(det_window)
                    rel_l   = (maximum(l_window)   - minimum(l_window))   / mean(l_window)

                    # Break if difference is not changing for last K iterations
                    if rel_det < tol && rel_l < tol
                        # println("Converged after $count samples (rel_det=$rel_det, rel_l=$rel_l)")
                        break
                    end
                end
            end
        end
    end

    return L_local, countAll
end




"""
Zusatzfunktion 1: estimate_RR
"""
# 1. Optimal für hybrid1_dep_wnlfb (mit SVector und übergebenem RNG)
@inline function estimate_RR_svec(rng::AbstractRNG, x::AbstractVector{<:SVector}, ε::T) where {T<:AbstractFloat}
    N = length(x)
    total_pairs = N * (N - 1) ÷ 2
    ε2 = ε^2
    hits = 0  
    samples = min(2000, max(1, round(Int, 0.1 * total_pairs)))

    # NUR @inbounds! Kein @simd wegen rand() und kein @fastmath für Integer.
    @inbounds for _ in 1:samples
        d = rand(rng, 1:(N-1))
        j_start = rand(rng, 1:(N - d))
        i_start = j_start + d
        
        if sq_dist(x, i_start, j_start) <= ε2
            hits += 1
        end
    end
    
    return hits / samples
end

# 2. Alte Version exklusiv für smi_lfb (Matrix, 2 Argumente, ohne RNG-Objekt)
@inline function estimate_RR(x::AbstractMatrix{T}, ε::T) where {T<:AbstractFloat}
    N, dim = size(x)
    total_pairs = N * (N - 1) ÷ 2
    ε2 = ε^2
    hits = 0  
    samples = min(2000, max(1, round(Int, 0.1 * total_pairs)))

    @inbounds for _ in 1:samples
        d = rand(1:(N-1))
        j_start = rand(1:(N - d))
        i_start = j_start + d
        
        # Manuelle Distanzberechnung, da sq_dist nur für SVector existiert
        D2 = zero(T)
        for k in 1:dim
            D2 += (x[i_start, k] - x[j_start, k])^2
        end
        
        if D2 <= ε2
            hits += 1
        end
    end
    
    return hits / samples
end

"""
Zusatzfunktion 2: estimate_W 
"""
@inline function sample_sojourn_time(rng::AbstractRNG, x::AbstractVector{<:SVector}, ε2::T, N::Int) where {T<:AbstractFloat}
    idx = rand(rng, 2:N)  
    misses = 0
    offset = 1
    idx_minus_offset = idx - offset
    
    last_black_W = 0 
    current_W = 0
    max_misses = 3

    @inbounds while misses <= max_misses && idx_minus_offset >= 1
        current_W += 1

        if sq_dist(x, idx, idx_minus_offset) <= ε2
            misses = 0  
            last_black_W = current_W 
        else
            misses += 1
        end

        offset += 1
        idx_minus_offset = idx - offset
    end
    
    return last_black_W
end

function estimate_W(rng::AbstractRNG, x::AbstractVector{<:SVector}, ε::T) where {T<:AbstractFloat}
    N = length(x)
    ε2 = ε^2

    w1 = sample_sojourn_time(rng, x, ε2, N)
    w2 = sample_sojourn_time(rng, x, ε2, N)
    w3 = sample_sojourn_time(rng, x, ε2, N)
    w4 = sample_sojourn_time(rng, x, ε2, N)
    w5 = sample_sojourn_time(rng, x, ε2, N)

    return round(Int, median(SVector(w1, w2, w3, w4, w5)))
end

"""
Zusatzfunktion 3: sq_dist 
"""
@inline function sq_dist(x::AbstractVector{<:SVector}, i::Int, j::Int)
    # @inbounds hier hinzugefügt, damit das Auslesen aus x keine Array-Grenzen prüft
    @inbounds p_i = x[i] # wir haben doch mit dem Svector dim in den zeilen und die zeit in den spalten?!? wenn nur ein idx, also x[i] übergeben wird, dann sit das doch eigentlich die zeile? und wie beschrieben, wollen wir ja i und j als zeitpunkt angeben?!? 
    @inbounds p_j = x[j]
    return sum(abs2, p_i - p_j)
end

"""
Zusatzfunktion 4: calc_rel_change
"""
@inline function calc_rel_change(window)
    # Diese Funktion ist absolut optimal für kleine Fenster (1-Pass-Algorithm)
    mn = mx = sum_val = window[1]
    @inbounds for i in 2:length(window)
        val = window[i]
        if val < mn; mn = val; end
        if val > mx; mx = val; end
        sum_val += val
    end
    avg = sum_val / length(window)
    return avg == 0.0 ? 1.0 : (mx - mn) / avg # Falls in den ersten $W_{\text{conv}}$ Iterationen noch keine Linien der Länge $\ge 2$ gefunden wurden, ist sum_n2_L = 0.0 und somit avg = 0.0. Das führt in calc_rel_change zu einer $0/0$-Division (NaN). In Julia ist NaN < tol immer false, weshalb der Code zwar nicht falsch abbricht, aber eine explizite Prüfung vermeidet unnötige NaN-Arithmetik in der CPU
end

"""
Zusatzfunktion 5: check_periodicity_block
"""

@inline function check_periodicity_block(x::AbstractVector{<:SVector}, N::Int, check_length::Int, max_misses::Int, period_equidistance_error::Int, W_soujorn::Int, max_fails::Int, ε2::Float64)
    long_lines = 0
    d1 = d2 = d3 = d4 = d5 = -1 
    d12 = d23 = d34 = d45 = d13 = d24 = d14 = d15 = d25 = d35 = 0 
    
    i = N - check_length 
    current = i - max(3, W_soujorn) 
    failed_attempts = 0
    
    @inbounds while current >= 1
        if failed_attempts >= max_fails
            return false
        end
        
        if sq_dist(x, i, current) <= ε2
            is_long_line = true
            misses = 0
            @inbounds for offset in 1:check_length
                if sq_dist(x, i+offset, current+offset) > ε2          
                    misses += 1
                    if misses >= max_misses
                        is_long_line = false
                        failed_attempts += 1
                        break
                    end
                else
                    misses = 0
                end
            end
            
            if is_long_line                                   
                d = i - current
                if long_lines == 0
                    long_lines += 1; d1 = d; current -= W_soujorn
                elseif long_lines == 1
                    long_lines += 1; d2 = d; current -= W_soujorn
                elseif long_lines == 2
                    long_lines += 1; d3 = d; current -= W_soujorn
                    d12 = d1 - d2; d23 = d2 - d3
                    if abs(d12-d23) <= period_equidistance_error         
                        return true
                    end
                elseif long_lines == 3
                    long_lines += 1; d4 = d; current -= W_soujorn
                    d34 = d3 - d4; d24 = d2 - d4; d13 = d1 - d3
                    if (abs(d12-d24) <= period_equidistance_error ) || 
                       (abs(d13-d34) <= period_equidistance_error ) || 
                       (abs(d23-d34) <= period_equidistance_error )
                        return true
                    end
                elseif long_lines == 4
                    long_lines += 1; d5 = d; current -= W_soujorn
                    d15 = d1 - d5; d25 = d2 - d5; d35 = d3 - d5; d45 = d4 - d5
                    if (abs(d12-d25) <= period_equidistance_error ) || 
                       (abs(d13-d35) <= period_equidistance_error) ||
                       (abs(d14-d45) <= period_equidistance_error) || 
                       (abs(d23-d35) <= period_equidistance_error) || 
                       (abs(d24-d45) <= period_equidistance_error) || 
                       (abs(d34-d45) <= period_equidistance_error)          
                        return true
                    else
                        return false 
                    end
                end
            else
                current -= 1 
            end
        else
            current -= 1 
        end
    end 
    return false
end

"""
Zusatzfunktion 6: rand_sample_lfb_svec
"""
function rand_sample_lfb_svec(rng::AbstractRNG, x::AbstractVector{<:SVector}, ε2::T, M::Int, W_theiler::Int, W_soujourn::Int, true_line_test::Bool = false) where {T<:AbstractFloat}
    N = length(x)
    L_local = zeros(Float64, N)
    
    total_pairs = N * (N - 1) >> 1
    max_searches = max(M * 200, total_pairs << 1)
    
    K = 50              
    W_conv = 5               
    tol = 1e-3          
    min_samples = 500   
    
    det_ring = zeros(Float64, W_conv)
    l_ring   = zeros(Float64, W_conv)
    ring_idx = 1
    history_count = 0
    sum_n2_L = 0.0   
    sum_L2   = 0.0   
    
    count = 0                         
    countAll = 0 

    while count < M # weshalb kein inbounds oder so?
        if countAll > max_searches; break; end
        countAll += 1                 

        u1 = rand(rng, 1:N)    # irgendwie W_theiler und W_soujorn hier berücksichtigen??
        u2 = rand(rng, 1:N)
        if u1 == u2; continue; end    # das heißt doch, dass wenn u1 = u2 dann zählen wir ein countAll dazu, ohne dass eine prüfung durchgeführt worden ist??
        j_start, i_start = minmax(u1, u2)  # heißt das linke bekommt das min und das rechte das max zugewiesen?? also für oberes dreieck, wenn die LOI von links unten nachr echts oben, ist j die x achse (spalten) und i die  y (zeilen) ?

        if sq_dist(x, i_start, j_start) > ε2; continue; end

        cnt = 1 
        @inbounds for offset in 1:(N - i_start) 
            if sq_dist(x, i_start + offset, j_start + offset) <= ε2; cnt += 1; else; break; end
        end
        @inbounds for offset in 1:(j_start-1) 
            if sq_dist(x, i_start - offset, j_start - offset) <= ε2; cnt += 1; else; break; end
        end
        
        if cnt > 0 
            weight = 1.0 / cnt
            @inbounds L_local[cnt] += weight    
            count += 1                

            is_long = cnt >= 2
            sum_n2_L += is_long
            sum_L2   += is_long * weight

            if count % K == 0 && count >= min_samples
                @inbounds det_ring[ring_idx] = sum_n2_L / count
                @inbounds l_ring[ring_idx]   = sum_n2_L / sum_L2
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

"""
Zusatzfunktion 7: smi_lfb_svec
"""
function smi_lfb_svec(rng::AbstractRNG, x::AbstractVector{<:SVector}, ε2::T, M::Int, estimated_RR::Float64, s::Union{Float64, Nothing}, W_theiler::Int, W_soujourn::Int) where {T<:AbstractFloat}
    N = length(x)
    L_local = zeros(Float64, N)
    
    total_pairs = N * (N - 1) >> 1
    max_searches = max(M * 200, total_pairs << 1)
    
    K = 50              
    W_conv = 5               
    tol = 1e-3          
    min_samples = 500   
    
    # High-Performance Float Konstanten NUR hier! weshalb? wozu den kram anyways??
    N2_1 = 2.0 * N - 1.0
    N2_1_sq = Float64(N2_1)^2
    
    det_ring = zeros(Float64, W_conv)
    l_ring   = zeros(Float64, W_conv)
    ring_idx = 1
    history_count = 0
    sum_n2_L = 0.0   
    sum_L2   = 0.0   
    
    count = 0                         
    countAll = 0 

    @inbounds actual_s = (s !== nothing) ? s : (estimated_RR < 0.05 ? 5.0 : (estimated_RR > 0.2 ? 0.5 : 1.0))
    @inbounds estimated_tries_per_box = (estimated_RR < 0.05 ? 50 : (estimated_RR > 0.2 ? 12 : 24))

    @inbounds s_tilde = M * actual_s
    @inbounds num_boxes = min(total_pairs, max(1, round(Int, s_tilde)))
    @inbounds box_length_dyn = total_pairs ÷ num_boxes 
    
    @inbounds active_boxs = Vector{Int}(undef, num_boxes)
    @inbounds active_box_count = 0
    @inbounds box_lower_bounds = Vector{Int}(undef, num_boxes)
    @inbounds box_upper_bounds = Vector{Int}(undef, num_boxes)

    
    @inbounds for current_box in 1:num_boxes                     # hier noch W_theiler und ?unten dann erst? W_soujorn integrieren! indem man beim durchgehen der zu prüfenden boxs W_theiler und W_soujorn berücksichtigt?! in dem die ersten W_theiler diagonalen also alles d<W_theiler tabu sind?! und W_soujorn dann indem wir immer, wenn auf einer diagonalen maximal xx mal einen rand punkt auf der diag samplen und sobald einer schwarz ist den eine box aktiviert worden ist auf dieser diagonale in beide richtungen die boxs prüfen, wobei in beide richtungen ein eigenes max_misses läuft und nach mehr als einer box nicht aktiviert wird abgebrochen in die jeweilige richtung und wenn mehr als  box auf déiner diagonalen aktiviert worden ist, also ganz einfach, wenn eine box in der following schleife aktiviert wird in einer richtung wird, falls noch nicht geschehen long_diag auf true gesetzt und dann also alle boxen auf der diag aktiviert und . heißt alo auch wir gehen die diagonalen durch beim box aktivieren (box aktivieren sollte eine eigene funktion sein oder? noch mehr externe funktionen noch in den beiden samplings definieren?) und zwar startend von d = W_theiler+1 (sollten wir dann trotzdessen die boxs im rqa sampling mit rand durchgehen oder ist dann hintereinander besser? ne?! dann finden wir ja wieder hintereinander immer wieder die selbe linie?!)
        l_b = (current_box-1) * box_length_dyn + 1
        u_b = current_box == num_boxes ? total_pairs : current_box * box_length_dyn
        box_lower_bounds[current_box] = l_b
        box_upper_bounds[current_box] = u_b

        for _ in 1:estimated_tries_per_box 
            idx = rand(rng, l_b:u_b)     
            #d = ceil(Int, (N2_1 - sqrt(N2_1_sq - 8.0 * Float64(idx))) * 0.5)    # wozu ceil? die mathe hier und bei folgenden zeilen?
            val = N2_1_sq - 8.0 * idx # idx wird automatisch schnell zu Float64 promoted
            S_int = trunc(Int, sqrt(val))
            d = (N2_1 - S_int + 1) >> 1
            d_minus = d - 1
            previous_elements = d_minus * N - (d_minus * d >> 1)
            j_start = idx - previous_elements     
            i_start = j_start + d

            if sq_dist(x, i_start, j_start) <= ε2
                active_box_count += 1
                active_boxs[active_box_count] = current_box    # zero allocation trick hier anwendbar?? also ohne array oder liste die boxs irwei speichern?!?
                break 
            end
        end
    end

    if active_box_count == 0; return L_local, countAll; end  # alles leer returnen, da eh nichts geprüft würde, keine boxs aktiv, da wohl RP zu leer oder ε zu klein, nicht ein schwarzer punkt in irgendeiner box gefunden.

    sum_n_L = 0.0
    while count < M # weshalb kein inbounds oder so?
        if countAll > max_searches; break; end
        @inbounds current_box = active_boxs[rand(rng, 1:active_box_count)]   # um dicke linien und verweilungsartefakte, soujorn kram zu vermeiden zufällige boxs und nicht der reihe nach
        
        countAll += 1                 
        @inbounds idx = rand(rng, box_lower_bounds[current_box]:box_upper_bounds[current_box])     

        val = N2_1_sq - 8.0 * idx # idx wird automatisch schnell zu Float64 promoted
        S_int = trunc(Int, sqrt(val))
        d = (N2_1 - S_int + 1) >> 1   
        d_minus = d - 1
        previous_elements = d_minus * N - (d_minus * d >> 1)
        j_start = idx - previous_elements     
        i_start = j_start + d                 

        if sq_dist(x, i_start, j_start) > ε2; continue; end

        cnt = 1 
        @inbounds for offset in 1:(N - i_start) 
            if sq_dist(x, i_start + offset, j_start + offset) <= ε2; cnt += 1; else; break; end
        end
        @inbounds for offset in 1:(j_start-1) 
            if sq_dist(x, i_start - offset, j_start - offset) <= ε2; cnt += 1; else; break; end
        end
        
        if cnt > 0 
            weight = 1.0 / cnt
            @inbounds L_local[cnt] += weight         
            count += 1                
            
            sum_n_L  += cnt * weight
            is_long = cnt >= 2
            sum_n2_L += is_long ? cnt * weight : 0.0
            sum_L2   += is_long * weight

            if count % K == 0 && count >= min_samples
                @inbounds det_ring[ring_idx] = sum_n2_L / sum_n_L
                @inbounds l_ring[ring_idx]   = sum_n2_L / sum_L2
                ring_idx = (ring_idx % W_conv) + 1
                history_count += 1
                
                if history_count >= W_conv && calc_rel_change(det_ring) < tol && calc_rel_change(l_ring) < tol
                    break
                end
            end
        end          
    end

    @inbounds countAll_correct_scaled = div(Int128(countAll) * num_boxes, active_box_count)
    return L_local, countAll_correct_scaled
end

"""
Zusatzfunktion 8:
"""



"""
Zusatzfunktion 9: estimate_epsilon_sq_by_rr(rng, x, target_rr; samples)

Berechnet das optimale ε^2, sodass die Rekurrenzmatrix eine vorgegebene 
Target-Recurrence-Rate (z.B. 0.05 für 5%) aufweist.
Nutzt einen hocheffizienten Monte-Carlo-Quantil-Schätzer.
"""
function estimate_epsilon_sq_by_rr(rng::AbstractRNG, x::AbstractVector{<:SVector}, target_rr::Float64; samples::Int=100000)
    N = length(x)
    total_pairs = (N * (N - 1)) >> 1
    
    # Wenn die Matrix sehr klein ist, nehmen wir alle Paare, sonst die festgelegte Sample-Zahl
    actual_samples = min(samples, total_pairs)
    
    # Pre-Allokation für maximale Geschwindigkeit
    D2_samples = Vector{Float64}(undef, actual_samples)
    
    count = 1
    @inbounds while count <= actual_samples
        # 1. Uniformes Ziehen im oberen Dreieck ohne teure Wurzel-Mathematik (Index-Mapping)
        u1 = rand(rng, 1:N)
        u2 = rand(rng, 1:N)
        
        if u1 == u2
            continue # LOI ignorieren
        end
        
        # minmax sorgt dafür, dass j immer die Spalte (kleiner) und i die Zeile (größer) ist
        j, i = minmax(u1, u2)
        
        # 2. Quadrierte Distanz berechnen
        D2_samples[count] = sq_dist(x, i, j)
        count += 1
    end
    
    # 3. Das Quantil bestimmen. 
    # quantile! sortiert/mutiert das Array in-place (O(N) Zeitkomplexität im Best-Case)
    # und ist deutlich schneller als eine vollständige Sortierung (sort!).
    optimal_eps2 = quantile!(D2_samples, target_rr)
    
    return optimal_eps2
end

"""
get_hist_diagonal_woRP_sceletonization

woRP with true_line_test
"""

function get_hist_diagonal_woRP(x, ε, true_line_test = true)
    N, dim = size(x)                  # Number of observations and variables
    L = zeros(Int, N)                 # Histogram for line lengths
    ε2 = ε^2                          # Precompute squared threshold (avoids sqrt)

    @inbounds for i in 2:N # start with 2 to remove main diagonal
        cnt = 0
        @inbounds for j in 1:(N - i + 1)
            # Direct squared Euclidean distance computation

            # variant 1 (needs to replace test D2 < ε2 with D < ε)
#             @views diff .= x[i + j - 1, :] .- x[j, :]  # Avoid creating a new array
#             #diff .= x[i + j - 1, :] .- x[j, :]  ## Causes many allocations
#             D = norm(diff)  # Reuse `diff` instead of allocating new memory
            
            # variant 2 (needs to replace test D2 < ε2 with D < ε)
            # D = norm(x[i + j - 1, :] - x[j, :])
            
            # variant 3
            D2 = 0.0
            @inbounds for k in 1:dim
                D2 += (x[i + j - 1, k] - x[j, k])^2
            end

            if D2 <= ε2
                cnt += 1              # Extend current diagonal
            else
                if cnt > 0
                    L[cnt] += 1       # Store completed line length
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