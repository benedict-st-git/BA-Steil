open("my_test_ausgaben_2.txt", "w") do io
    redirect_stdout(io) do
        include("my_test_big_RP_6.jl")
    end
end

