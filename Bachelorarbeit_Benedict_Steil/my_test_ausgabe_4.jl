# ====================================================================
# Absturzsicherer Wrapper OHNE redirect_stdout
# ====================================================================

ausgabe_pfad = joinpath(@__DIR__, "my_test_ausgaben_2.txt")
skript_pfad  = joinpath(@__DIR__, "my_test_big_RP_6.jl")

println("INITIALISIERUNG: Lade Benchmark-Suite...")
println("LOGFILE PFAD:    ", ausgabe_pfad)

# Verhindert, dass include() die Suite schon vorab ohne Datei-Stream startet
global AUTO_RUN_MAIN = false

include(skript_pfad)

open(ausgabe_pfad, "w") do io
    try
        # Übergibt den Datei-Stream direkt an die Suite (kein redirect_stdout!)
        main_test_suite(io)
    catch e
        bt = catch_backtrace()
        println(stderr, "\n" * "="^70)
        println(stderr, " FEHLER ABGEFANGEN (KEIN REPL-ABSTURZ):")
        println(stderr, "="^70)
        showerror(stderr, e, bt)
        println(stderr, "\n" * "="^70)
        
        println(io, "\n" * "="^70)
        println(io, " FEHLER ABGEFANGEN:")
        println(io, "="^70)
        showerror(io, e, bt)
        println(io, "\n" * "="^70)
        flush(io)
    end
end

global AUTO_RUN_MAIN = true
println("\nABSCHLUSS: Ergebnisse erfolgreich in 'my_test_ausgaben_2.txt' gespeichert.")