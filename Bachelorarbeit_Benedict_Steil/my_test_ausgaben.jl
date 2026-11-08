open("my_test_ausgaben_2.txt", "w") do io
    redirect_stdout(io) do
        include("my_test_big_RP_5.jl")
    end
end

# periodizitätsprüfung als externe fnkt und ?alles? womit gerechnet wird als floats und keine ints. keine wurzeln mehr?!?