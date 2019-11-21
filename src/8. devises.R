#reload R
library(quantmod)

dateFrom="2019-06-01"

df1 <- getFX("USD/XPF", from=dateFrom, auto.assign=FALSE)
plot(df1)

currencies<-lapply(c("CAD", "USD", "JPY", "NZD", "AUD"), 
                   function(x) {
                     getFX(paste0(x,"/XPF"),
                           from=dateFrom,
                           auto.assign=FALSE)
                   })

flat<-lapply(currencies, 
             function(x) {
               y<-as.data.frame(x)
               cbind(
                 rep(colnames(y),nrow(y)),
                 row.names(y),
                 y[,1])}
)
z<-as.data.frame(do.call(rbind, flat))
colnames(z)<-c("Devise", "Date", "Taux")


chartSeries(currencies[[1]])
chartSeries(currencies[[2]])
chartSeries(currencies[[3]])
chartSeries(currencies[[4]])
chartSeries(currencies[[5]])
to.weekly(currencies[[2]])
