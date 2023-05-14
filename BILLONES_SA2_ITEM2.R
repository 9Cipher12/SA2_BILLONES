#SA2 -- ITEM 2

EthData <- file.choose()
eth <- read.csv(EthData)

returns <- diff(log(eth$Close))


library(nortest)
shapiro.test(returns)


