function run_with_tee(script_name::String, log_file::String)
    old_stdout = stdout
    rd, wr = redirect_stdout() # Erzeugt eine echte OS-Level Pipe
    
    # Asynchroner Task liest die Pipe und schreibt in Terminal + Datei
    reader_task = @async begin
        open(log_file, "w") do f
            while !eof(rd)
                chunk = readavailable(rd)
                write(old_stdout, chunk)
                write(f, chunk)
                flush(old_stdout)
                flush(f)
            end
        end
    end
    
    try
        println(old_stdout, "Starte Ausführung von $script_name...")
        println(old_stdout, "Logs werden gespeichert in: $log_file\n")
        include(script_name)
    finally
        # Aufräumen: Output zurücksetzen und Warten bis Datei fertig geschrieben ist
        redirect_stdout(old_stdout)
        close(wr)
        wait(reader_task)
        println("\nAusführung beendet. Output erfolgreich gespeichert.")
    end
end

# Hier definierst du, welches Skript laufen soll und wie die Datei heißt:
run_with_tee("my_test_big_RP_2_ultra_opti.jl", "Unfassbare_optimierungen_an_hybrid1_dep_wnlfb_und_systemen.txt")