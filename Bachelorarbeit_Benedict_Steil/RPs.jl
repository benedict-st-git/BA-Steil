using Plots
#include("my_test_big_RP_2.jl") # die systeme
# wird der code komplett ausgeführt, wenn ich include... stehen habe und oben rechts play drücke? anscheinend!

# nur systeme:
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


# ---------------------------------------------------------
# KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
# ---------------------------------------------------------
t_harm_osc = range(0, step=0.1, length=N_points)
x_harm_osc = reshape(sin.(t_harm_osc), :, 1)

ε_harm_osc = 0.1 * (maximum(x_harm_osc) - minimum(x_harm_osc))   
M_harm_osc = Int(round(0.2 * N_points))


# ---------------------------------------------------------
# KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbares Rauschen
x_noise = reshape(randn(N_points), :, 1)

ε_noise = 0.1 * (maximum(x_noise) - minimum(x_noise))   
M_noise = Int(round(0.2 * N_points))


# ---------------------------------------------------------
# KLASSE 4: DRIFT (RANDOM WALK)
# ---------------------------------------------------------
Random.seed!(123) # Reproduzierbarer Random Walk
x_drift = reshape(cumsum(randn(N_points)), :, 1)

ε_drift = 0.1 * (maximum(x_drift) - minimum(x_drift))   
M_drift = Int(round(0.2 * N_points))




# RPs plotten und speichern:
function save_recurrence_plot(system_name::String, x::AbstractMatrix, ε::Float64; N_sys::Int)
    
    # OPTIMIERUNG 1: falses() generiert eine hochperformante BitMatrix statt Int64
    R = falses(N_sys, N_sys) 
    
    # OPTIMIERUNG 2: Quadrierten Schwellenwert berechnen, um sqrt() im Loop zu vermeiden
    ε2 = ε^2 
    
    @inbounds @fastmath for i in 1:N_sys
        for j in 1:i
            D2 = 0.0                  
            for k in 1:size(x, 2)  
                D2 += (x[i, k] - x[j, k])^2
            end
            
            # Vergleich ohne teure sqrt()-Funktion
            if D2 <= ε2   
                R[i, j] = true
                R[j, i] = true 
            end
        end
    end

    safe_name = replace(system_name, r"[^a-zA-Z0-9_]" => "_") # ???????
    filename = "RP_$(safe_name).png"                          # ?????

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
    println("-> Recurrence Plot erfolgreich gespeichert unter: $filename")
end

# Damit der Plotter nicht nochmal die 1000 Benchmarks durchführt, rufen wir hier nur die Generatoren auf:
println("\nStarte Plotting-Prozess...")

save_recurrence_plot("KLASSE 1: CHAOS (ROESSLER SYSTEM)", x_c1, ε_c1, N_points)
save_recurrence_plot("KLASSE 1: CHAOS (LORENZ SYSTEM)", x_lorenz, ε_lorenz, N_points)
save_recurrence_plot("KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc, ε_harm_osc, N_points)
save_recurrence_plot("KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise, N_points)
save_recurrence_plot("KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift, N_points)

println("Alle Plots wurden generiert!")