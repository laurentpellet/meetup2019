library(data.table)
set.seed(2L)
N = 5e6L


gc()

#Création du dataset
DT = data.table(x = sample(letters, N, TRUE),
                y = sample(1000L, N, TRUE),
                z = sample(100000L, N, TRUE),
                val = runif(N))
print(object.size(DT), units = "Mb")


fwrite(DT, "input/5million.csv")
DT <- fread("input/5million.csv")

