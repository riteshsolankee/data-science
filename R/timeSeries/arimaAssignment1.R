data(AirPassengers)
class(AirPassengers)

head(AirPassengers)
frequency(AirPassengers)
cycle(AirPassengers)
seasonplot(AirPassengers)

library(forecast)
data(EuStockMarkets) # data on European stock markets

class(EuStockMarkets)
summary(EuStockMarkets)
head(EuStockMarkets)
start(EuStockMarkets)
end(EuStockMarkets)

### Checking sesonality
frequency(EuStockMarkets) ## 52 weeks * 5 working day
seasonplot(EuStockMarkets[,"DAX"])

### Ploting trend
# data from Germany
plot.ts(EuStockMarkets)
plot(EuStockMarkets[,"DAX"])
plot(aggregate(EuStockMarkets[,"DAX"],FUN=mean))

plot(EuStockMarkets[,"SMI"])
plot(EuStockMarkets[,"CAC"])
plot(EuStockMarkets[,"FTSE"])

plot(diff(log(EuStockMarkets))[,"DAX"])
plot(diff(diff(log(EuStockMarkets)))[,"DAX"])

dax <- diff(log(EuStockMarkets))[,"DAX"]
plot(dax)
acf(dax, lag.max = 600)
pacf(dax, lag.max = 600)

# try to fit simple ARMA models
ar <- arima(log(EuStockMarkets)[,"DAX"],order=c(0,1,0))
ar # autoregression term not significant
BIC(ar)

ma <- arima(log(EuStockMarkets)[,"DAX"],order=c(0,1,0)) #MA(1) model with mean = 0
ma # moving average not significant
BIC(ma)


arma <- arima(log(EuStockMarkets)[,"DAX"],order=c(1,1,1)) #MA(1) model with mean = 0
arma # moving average not significant
BIC(arma)


### Either AR or MA will work