
#AR model estimation and forecasting

install.packages("Ecdat")

library(Ecdat)

data(Mishkin,package = "Ecdat")

#explore and inspect data series

inflation <-as.ts(Mishkin[,1])
ts.plot(inflation)
acf(inflation)

inflation_change <- diff()

AR_inflation<- arima(inflation,order = c(1,0,0))

print(AR_inflation)

AR_inflation_fitted<-inflation - residuals(AR_inflation)

ts.plot(inflation)

points(AR_inflation_fitted,type = "l", col = "red", lty = 2)

stl(inflation, s.window="periodic")

plot(stl(inflation, s.window="periodic"))
