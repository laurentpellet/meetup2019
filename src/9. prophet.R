library(prophet)
df <- read.csv('input/example_wp_log_peyton_manning.csv')
plot(df$ds, df$y)

m <- prophet(df)
future <- make_future_dataframe(m, periods = 365)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)
prophet_plot_components(m, forecast)