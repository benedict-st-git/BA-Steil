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
Sampling 2: Stratified Sampling (RPLL(RPLineLengths) als Basis - no combinations))
    -
    xxxx
"""

function get_hist_diagonal_sampled(x::AbstractMatrix{T}, ε::T, M::Int) where {T<:AbstractFloat}
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
    
    box_length_dyn = total_pairs / M

    while count < M

        lower_bound = Int(floor((count * box_length_dyn) + 1))
        upper_bound = Int(floor((count+1) * box_length_dyn))

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
        
        if upper_bound >= total_pairs && count < M
            # println("Warning: Reached end of index range before finding M lines. Found $count lines after checking all pairs.")
            # break

        end
        
    end

    return L_local, countAll
end
