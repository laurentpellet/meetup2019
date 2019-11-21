library(microbenchmark)
library(ggplot2)
library(data.table)
set.seed(2L)
N = 1e8L


gc()

#Création du dataset
DT = data.table(x = sample(letters, N, TRUE),
                y = sample(1000L, N, TRUE),
                z = sample(100000L, N, TRUE),
                val = runif(N))

head(DT)

print(object.size(DT), units = "Mb")

t1 <- system.time(ans1 <- DT[x == "g" & y == 877L])
t1


DT2 <- copy(DT)
setkeyv(DT, c("x", "y"))
t2 <- system.time(ans2 <- DT2[.("g", 877L)])
t2

#recherche un subset en particulier
DT[x == "g" & y == 877L]
DT2[.("g",877L)]



#deux fonctions de recherche
rechercheScan <- function(data, valX,valY){
  data[x == valX & y == valY]
}
rechercheBinary <- function(data, valX,valY){
  data[.(valX,valY)]
}

rechercheScan(DT, sample(letters,1), sample(1000,1))
rechercheScan(DT2, sample(letters,1), sample(1000,1))
rechercheBinary(DT2, sample(letters,1), sample(1000,1))


system.time(DT[,.N, by=y][order(y)])
DT[,.N, by=y][order(y)]


mbm <- microbenchmark("recherche sans clé - vector scan" = {rechercheScan(DT, sample(letters,1), sample(1000,1))},
                      "recherche avec clé - vector scan" = {rechercheScan(DT, sample(letters,1), sample(1000,1))},
                      "recherche avec clé - binary scan" = {rechercheBinary(DT, sample(letters,1), sample(1000,1))},
                      "group by " = {DT[,.N, by=y]},
                      #"group by ordonné" = {DT2[,.N, by=y][order(y)]},
                      times = 10)

mbm
autoplot(mbm)

