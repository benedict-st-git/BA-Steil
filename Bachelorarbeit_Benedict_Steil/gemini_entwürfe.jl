"""
    aRQA
    entwurf von gemini, da ich das später vlt noch selber implementieren will
"""

using StatsBase

"""
    Approximate RQA (aRQA) basierend auf Spiegel et al. 2016.
    Berechnet RR, DET und L in extrem kurzer Zeit (ohne RP).
"""
function get_approx_rqa(x::AbstractMatrix{T}, ε::T, μ::Int) where {T<:AbstractFloat}
    N, dim = size(x)

    # 1. Discretization: Werte in diskrete Bins einteilen
    x_disc = floor.(Int, x ./ (2 * ε))

    # 2. Hilfsfunktion: Time Delay Embedding (unit time delay = 1)
    function fTDE(traj::Matrix{Int}, m::Int)
        n_points, d = size(traj)
        out_len = n_points - m + 1
        out = zeros(Int, out_len, d * m)
        for i in 1:m
            out[:, d*(i-1)+1 : d*i] = traj[i : i+out_len-1, :]
        end
        return out
    end

    # 3. Hilfsfunktion: Pairwise Proximities berechnen
    function fPProximities(traj::Matrix{Int})
        # Zählt die absolute Häufigkeit jedes einzigartigen Zustands (Zeile)
        counts = collect(values(countmap(eachrow(traj))))
        # Inneres Produkt (Summe der quadrierten Häufigkeiten)
        return sum(counts.^2)
    end

    # Embeddings erstellen (μ und μ+1 für DET und L)
    x_emb_1  = fTDE(x_disc, 1)      # Für PP^(1)
    x_emb_mu = fTDE(x_disc, μ)      # Für PP^(μ)
    x_emb_mu1 = fTDE(x_disc, μ + 1) # Für PP^(μ+1)

    # Pairwise Proximities zählen
    pp1 = fPProximities(x_emb_1)
    pp_mu = fPProximities(x_emb_mu)
    pp_mu1 = fPProximities(x_emb_mu1)

    # 4. RQA Maße algebraisch berechnen
    # Hinweis: Wie im MATLAB-Code des Papers wird hier die Hauptdiagonale 
    # (N) nicht explizit abgezogen.
    RR = pp1 / (N * N)
    DET = (μ * pp_mu - (μ - 1) * pp_mu1) / (pp1 + 1e-10)
    
    # L = Zähler (wie bei DET) / Anzahl der Linien
    L = (μ * pp_mu - (μ - 1) * pp_mu1) / (pp_mu - pp_mu1 + 1e-10)

    return RR, DET, L
end