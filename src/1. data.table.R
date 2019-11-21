library(data.table)

fileName <- "input/5million.csv"
#fileName <- "input/50million.csv"
file.info(fileName)$size
fs::file_info(fileName)$size

dt <- fread(fileName)

head(dt,10)
str(dt)
object.size(dt)
print(object.size(dt), units = "Mb")
summary(dt)


dt[1]
dt[1:5]
dt[1:5,.(x, y)]
dt[1:5,.(x, val)]


dt[1:5,.(x, y)][1,2]
dt[1:5,.(x, y)][,2]
dt[1:5,.(x, y)][,2][order(y)]
dt[1:5,.(x, y)][1,.(y)]



dt[,.N]
dt[x=="a",.N]
dt[,.N, by=x]
head(dt[,.N, by=x])
head(dt[,.N, by=x][order(x)])

