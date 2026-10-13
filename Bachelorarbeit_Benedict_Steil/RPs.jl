using Plots
using DifferentialEquations
using Random

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


# ---------------------------------------------------------
# KLASSE 1: CHAOS (LORENZ SYSTEM)
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


# ---------------------------------------------------------
# KLASSE 2.1: BE (bad embedding (antidiagonalen)) PERIODIC (HARMONIC OSCILLATOR) 
# ---------------------------------------------------------
t_harm_osc_1 = range(0, step=0.1, length=N_points)
x_harm_osc_1 = reshape(sin.(t_harm_osc_1), :, 1)
ε_harm_osc_1 = 0.1 * (maximum(x_harm_osc_1) - minimum(x_harm_osc_1))   


# ---------------------------------------------------------
# KLASSE 2.2: PERIODIC (HARMONIC OSCILLATOR) - Dicke Linien
# ---------------------------------------------------------
t_harm_osc_2 = range(0, step=0.1, length=N_points)
x_harm_osc_2 = hcat(sin.(t_harm_osc_2), cos.(t_harm_osc_2))
ε_harm_osc_2 = 0.1 * (maximum(x_harm_osc_2) - minimum(x_harm_osc_2))   


# ---------------------------------------------------------
# KLASSE 2.3: PERIODIC (HARMONIC OSCILLATOR) - Gestrichelte Linien
# ---------------------------------------------------------
t_harm_osc_3 = range(0, step=0.61, length=N_points)
x_harm_osc_3 = hcat(sin.(t_harm_osc_3), cos.(t_harm_osc_3))
ε_harm_osc_3 = 0.1 * (maximum(x_harm_osc_3) - minimum(x_harm_osc_3))   


# ---------------------------------------------------------
# KLASSE 2.4: PERIODIC (HARMONIC OSCILLATOR) - Perfekte Resonanz
# ---------------------------------------------------------
t_harm_osc_4 = range(0, step=0.1*pi, length=N_points)
x_harm_osc_4 = hcat(sin.(t_harm_osc_4), cos.(t_harm_osc_4))
ε_harm_osc_4 = 0.1 * (maximum(x_harm_osc_4) - minimum(x_harm_osc_4))   


# ---------------------------------------------------------
# KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
# ---------------------------------------------------------
Random.seed!(123) 
x_noise = reshape(randn(N_points), :, 1)
ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   


# ---------------------------------------------------------
# KLASSE 4: DRIFT (RANDOM WALK)
# ---------------------------------------------------------
Random.seed!(123) 
x_drift = reshape(cumsum(randn(N_points)), :, 1)
ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   


# ====================================================================
# RPs plotten und speichern
# ====================================================================
function save_recurrence_plot(system_name::String, x::AbstractMatrix, ε::Float64; max_plot_size::Int=1000)
    
    # Verhindere OOM-Crash bei zu großen Matrizen fürs Plotten
    N_sys = min(size(x, 1), max_plot_size)
    
    # falses() generiert eine hochperformante BitMatrix
    R = falses(N_sys, N_sys) 
    ε2 = ε^2 
    
    @inbounds @fastmath for i in 1:N_sys
        for j in 1:i
            D2 = 0.0                  
            for k in 1:size(x, 2)  
                D2 += (x[i, k] - x[j, k])^2
            end
            
            if D2 <= ε2   
                R[i, j] = true
                R[j, i] = true 
            end
        end
    end

    # Säubere den Namen von Sonderzeichen, um OS-Fehler beim Speichern zu vermeiden
    safe_name = replace(system_name, r"[^a-zA-Z0-9_]" => "_") 
    filename = "RP_$(safe_name).png"                          

    p = heatmap(
        1:N_sys, 1:N_sys, R,
        c = cgrad([:white, :black]), 
        aspect_ratio = :equal,       
        legend = false,              
        xlims = (1, N_sys),
        ylims = (1, N_sys),
        xlabel = "Time (Index)",
        ylabel = "Time (Index)",
        title = system_name,
        framestyle = :box,
        grid = false,
        dpi = 300                    
    )

    savefig(p, filename)
    println("-> Recurrence Plot gespeichert unter: $filename (Größe: $N_sys x $N_sys)")
end


# ====================================================================
# Plot-Aufrufe
# ====================================================================
println("\nStarte Plotting-Prozess...")

save_recurrence_plot("KLASSE 1 - CHAOS (ROESSLER)", x_c1, ε_c1)
save_recurrence_plot("KLASSE 1 - CHAOS (LORENZ)", x_lorenz, ε_lorenz)

save_recurrence_plot("KLASSE 2.1 - PERIODIC BE (1D)", x_harm_osc_1, ε_harm_osc_1)
save_recurrence_plot("KLASSE 2.2 - PERIODIC PD (Dicke Linien)", x_harm_osc_2, ε_harm_osc_2)
save_recurrence_plot("KLASSE 2.3 - PERIODIC PD (Gestrichelte Linien)", x_harm_osc_3, ε_harm_osc_3)
save_recurrence_plot("KLASSE 2.4 - PERIODIC (Resonanz)", x_harm_osc_4, ε_harm_osc_4)

save_recurrence_plot("KLASSE 3 - WHITE NOISE", x_noise, ε_noise)
save_recurrence_plot("KLASSE 4 - DRIFT (RANDOM WALK)", x_drift, ε_drift)

println("\nAlle Plots wurden generiert!")