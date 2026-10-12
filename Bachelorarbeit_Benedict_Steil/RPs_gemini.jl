using Plots
include("my_test_big_RP_2.jl") # Lade die Daten

function save_recurrence_plot(system_name::String, x::AbstractMatrix, ε::Float64; max_pts::Int=2000)
    N_plot = min(size(x, 1), max_pts)
    
    # OPTIMIERUNG 1: falses() generiert eine hochperformante BitMatrix statt Int64
    R = falses(N_plot, N_plot) 
    
    # OPTIMIERUNG 2: Quadrierten Schwellenwert berechnen, um sqrt() im Loop zu vermeiden
    ε2 = ε^2 
    
    @inbounds @fastmath for i in 1:N_plot
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

    safe_name = replace(system_name, r"[^a-zA-Z0-9_]" => "_")
    filename = "RP_$(safe_name).png"

    p = heatmap(
        1:N_plot, 1:N_plot, R,
        c = cgrad([:white, :black]), 
        aspect_ratio = :equal,       
        legend = false,              
        xlims = (1, N_plot),
        ylims = (1, N_plot),
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

save_recurrence_plot("KLASSE 1: CHAOS (ROESSLER SYSTEM)", x_c1, ε_c1)
save_recurrence_plot("KLASSE 1: CHAOS (LORENZ SYSTEM)", x_lorenz, ε_lorenz)
save_recurrence_plot("KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)", x_harm_osc, ε_harm_osc)
save_recurrence_plot("KLASSE 3: HOMOGENOUS RP (WHITE NOISE)", x_noise, ε_noise)
save_recurrence_plot("KLASSE 4: DRIFT (RANDOM WALK)", x_drift, ε_drift)

println("Alle Plots wurden generiert!")