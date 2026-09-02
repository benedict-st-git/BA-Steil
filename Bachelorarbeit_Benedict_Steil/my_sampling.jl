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
Sampling 2.0.1: estimate_RR for Stratified Sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function estimate_RR(x::AbstractMatrix{T}, ε::T) where {T<:AbstractFloat}
    N, dim = size(x)
    total_pairs = N * (N - 1) ÷ 2
    ε2 = ε^2
    hits = 0  # Zählt die schwarzen Punkte
    samples = min(2000, max(1, Int(floor(0.1 * total_pairs))))

    for _ in 1:samples
        # 1. Ziehe einen zufälligen linearen Index
        idx = rand(1:total_pairs)
        
        # 2. Übersetze in (i, j)
        i = ceil(Int, (1 + sqrt(1 + 8*idx)) / 2)
        j = idx - (i - 1) * (i - 2) ÷ 2
        
        # 3. Berechne Distanz
        D2 = zero(T)
        @inbounds for k in 1:dim
            D2 += (x[i,k] - x[j,k])^2
        end
        
        # 4. Zähle Treffer
        if D2 <= ε2
            hits += 1
        end
    end
    
    # RR = (Schwarze Punkte) / (Alle gezogenen Punkte)
    return hits / samples
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
            D2_prev = 0.0 # verbesserung: zero(T) ?!
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
            D2_line = 0.0 # verbesserung: zero(T) ?!
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
            D2_line_following = 0.0 # verbesserung: zero(T) ?!
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
            D2_line_prev = 0.0 # verbesserung: zero(T) ?!
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
            D2_follow = 0.0 # verbesserung: zero(T) ?!
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
            D2_line = 0.0 # verbesserung: zero(T) ?!
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
    Sampling 4: (norbert for periodic or stratified- + memory + importance sampling with LFboth (optimized) for Drift, Noise and Chaotic) determined by xxxx value (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
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
    check_length = 50 # dynamisch besser !?
    LFboth_check_length = check_length ÷ 2
    check_goal = 5 # dynamisch besser !?
    is_periodic = false

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
                if check_periodicity
                    check_cnt += 1

                    # Black Point found, estimate periodicity
                    @inbounds for offset in 0:min(LFboth_check_length, (N - i_start)) 
                        D2_line_following = 0.0 # verbesserung: zero(T) ?!
                        for k in 1:dim
                            D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                        end
                        if D2_line_following > ε2          # Count points belonging to diagonal
                            check_periodicity = false # so check_cnt is not fortgeführt und bricht dann die prüfung der boxen für LFboth ab
                            break                 # Line ends
                        end
                    end
                    @inbounds for offset in 1:min(LFboth_check_length, (j_start-1)) 
                        D2_line_prev = 0.0 # verbesserung: zero(T) ?!
                        for k in 1:dim
                            D2_line_prev += (x[i_start - offset ,k] - x[j_start - offset ,k])^2
                        end
                        if D2_line_prev > ε2          # Count points belonging to diagonal
                            check_periodicity = false # so check_cnt is not fortgeführt und bricht dann die prüfung der boxen für LFboth ab
                            break                 # Line ends
                        end
                    end
                end
                break
            end
        end
        if check_cnt >= check_goal && check_periodicity
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
                D2_line_following = 0.0 # verbesserung: zero(T) ?!
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
                D2_line_prev = 0.0 # verbesserung: zero(T) ?!
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
    Sampling 4.1: (norbert for periodic or stratified- + memory + importance sampling with LFboth (optimized) for Drift, Noise and Chaotic) determined by xxxx value (RPLL(RPLineLengths) als Basis - 2 combinations in samplings)
    -
    xxxx
"""

function smi_LFboth_or_norbert_rand_with_LineLength_forward_condition(x::AbstractMatrix{T}, ε::T, M::Int; s::Union{Float64, Nothing} = nothing, auto_s::Bool = true, check_periodicity::Bool = true) where {T<:AbstractFloat}
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
    check_length = 50 # dynamisch besser !?
    long_lines_goal = 3 # dynamisch besser !?
    is_periodic = false
    long_lines = 0

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
                if check_periodicity
                    check_cnt += 1

                    # Black Point found, estimate periodicity
                    @inbounds for offset in 0:min(check_length, (N - i_start)) 
                        D2_line_following = 0.0 # verbesserung: zero(T) ?!
                        for k in 1:dim
                            D2_line_following += (x[i_start + offset,k] - x[j_start + offset,k])^2
                        end
                        if D2_line_following > ε2          # Count points belonging to diagonal
                            break                 # Line ends
                        else
                            long_lines += 1
                        end
                    end
                end
                break
            end
        end
        if long_lines >= long_lines_goal # && check_periodicity
            is_periodic = true
            break

        elseif check_cnt >= 10
            check_periodicity = false # so check_cnt is not fortgeführt und bricht dann die prüfung der boxen für LFboth ab
        end
    end

    if is_periodic
        
        println("--> NORBERTS SAMPLING (DETECTED AS PERIODIC)")
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
                D2_line_following = 0.0 # verbesserung: zero(T) ?!
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
                D2_line_prev = 0.0 # verbesserung: zero(T) ?!
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




