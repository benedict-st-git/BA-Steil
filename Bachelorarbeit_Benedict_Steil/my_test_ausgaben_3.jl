# 1. Absolute Pfade erzwingen (Ignoriert das VS Code Terminal pwd())
ausgabe_pfad = joinpath(@__DIR__, "my_test_ausgaben_2.txt")
skript_pfad  = joinpath(@__DIR__, "my_test_big_RP_6.jl")

println("INITIALISIERUNG: Starte Benchmark-Skript...")
println("LOGFILE PFAD:    ", ausgabe_pfad)

open(ausgabe_pfad, "w") do io
    # 2. Try-Catch fängt den "Exit Code 1" ab und macht den Fehler sichtbar
    try
        # 3. ANSI-Farbcodes blockieren, damit die .txt Datei sauber bleibt
        withenv("FORCE_COLOR" => "0", "JULIA_NO_COLOR" => "1") do
            redirect_stdout(io) do
                include(skript_pfad)
            end
        end
    catch e
        # 4. Standardfehler (stderr) wird NICHT umgeleitet.
        # Der echte Fehler wird jetzt grellrot im VS Code Terminal gedruckt,
        # OHNE den Julia-Prozess zu crashen.
        println(stderr, "\n" * "="^70)
        println(stderr, " KRITISCHER ABBRUCH (ABGEFANGEN)")
        println(stderr, "="^70)
        showerror(stderr, e, catch_backtrace())
        println(stderr, "\n" * "="^70)
    end
end

println("ABSCHLUSS: Logfile wurde geschlossen. (Siehe Datei oder Fehler oben)")