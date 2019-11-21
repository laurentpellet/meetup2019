library(dplyr)
library(dbplyr)
library(DBI)
library(data.table)
cat("Extraction des données ... ")
con <- dbConnect(odbc::odbc(),Driver = "SQL Server",Server = "sql",Database = "RP2017")
BI <- tbl(con, in_schema("Cube", "BI")) %>% collect() 
dtFL <- FL %>% as.data.table()
dtBI <- BI %>% as.data.table()
fwrite(BI, "output/BI.csv")

BI <- fread("input/BI.csv")

table(BI$`Categorie de population`)


