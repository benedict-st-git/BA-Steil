open("my_test_ausgaben_Unfassbare_optimierungen_an_hybrid1_dep_wnlfb.txt", "w") do io
    redirect_stdout(io) do
        include("my_test_big_RP_2_ultra_opti.jl")
    end
end