# %%
x = [1, 2, 3]
x .+= 1

function vektor(x)
    x[1] = 6
    x[2] = 7
    x[3] = 8
    return x
end

vektor(x)
# %%
round(31.5124352, digits = 2)
# %%
x[1:end-1]
