#setwd("C:/Users/laurentp/Desktop/meetup2019")
df <- read.csv2("input/prix.csv", stringsAsFactors = F)
df$Periode <- as.POSIXct(df$Periode)
fit <- stl(ts(df$Valeur,
              start=c(as.numeric(as.character(min(df$Periode), "%Y")),as.numeric(as.character(min(df$Periode), "%m"))),
              end  =c(as.numeric(as.character(max(df$Periode), "%Y")),as.numeric(as.character(max(df$Periode), "%m"))),
              frequency=12),
           s.window="periodic", t.window = 12)


plot(df$Periode, df$Valeur, type = "l")
plot(fit)
