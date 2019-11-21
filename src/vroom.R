library(data.table)
library("vroom")

system.time(dt <- fread("output/5million.csv"))
rm(dt)

gc()
system.time(dt <- vroom("output/5million.csv",
                        col_types = cols(x = col_character(),
                                         y=col_integer(),
                                         z=col_integer(),
                                         val=col_double())))
rm(dt)
gc()
dt


https://vroom.r-lib.org/articles/benchmarks.html
