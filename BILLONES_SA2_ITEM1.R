library(quantmod)
library(fitdistrplus)
library(ggplot2)

getSymbols("BTC-USD", from = "2012-01-01", to = "2023-04-15", src = "yahoo")
bitcoin_data <- read.csv("btcdata.csv")
returns <- diff(log(bitcoin_data$Close))

ggplot(data.frame(x = returns), aes(x)) + 
  geom_histogram(binwidth = 0.01, color = "black", fill = "white") + 
  labs(x = "Returns", y = "Frequency", title = "Bitcoin Returns Histogram")

descdist(returns)

fit_norm <- fitdist(returns, "norm")
fit_studt <- fitdist(returns, "t")
fit_laplace <- fitdist(returns, "laplace")
fit_cauchy <- fitdist(returns, "cauchy")

AIC_values <- c(fit_norm$aic, fit_studt$aic, fit_laplace$aic, fit_cauchy$aic)
distribution_names <- c("Normal", "Student's t", "Laplace", "Cauchy")

AIC_df <- data.frame(distribution_names, AIC_values)

AIC_df

AIC_df[which.min(AIC_df$AIC_values),]
