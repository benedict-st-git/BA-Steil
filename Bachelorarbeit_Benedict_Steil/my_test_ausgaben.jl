open("W_abstand_nach_gefundener_diag_in_zeile_i_UND_hybrid1_dep_womf_wnlfb_und_mit_konservativem_norbert.txt", "w") do io
    redirect_stdout(io) do
        include("my_test_big_RP_2.jl")
    end
end