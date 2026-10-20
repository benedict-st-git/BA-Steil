open("Unfassbare_optimierungen_an_hybrid1_dep_wnlfb.txt", "w") do io
    redirect_stdout(io) do
        include("my_test_big_RP_2.jl")
    end
end