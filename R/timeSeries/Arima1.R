# Chapter -3 
library(forecast)

# Simulting White Noise Model
WN_1 <- arima.sim(model = list(order=c(0,0,0)), n=5)
head(WN_1)
head(WN_1, 10)
ts.plot(WN_1)

# Simulatin white nosie modle with mean and SD
WN_2 <- arima.sim(model=list(order=c(0,0,0)), n=50, mean=4, sd=2)
ts.plot(WN_2)

# Extimating white nse Model
arima(WN_2, order=c(0,0,0))

# Alternatively
mean(WN_2)
var(WN_2)


# Generate a RW modle using arimi.sim
random_walk <- arima.sim(model = list(order=c(0,1,0)), n = 100)
ts.plot(random_walk)

#Calculate first difference series
random_walk_diff <- diff(random_walk)
ts.plot(random_walk_diff)

# Generate a RW model with a drift using arima.sim
rw_drift <- arima.sim(model=list(order=c(0,1,0)), n = 100, mean=1)
ts.plot(rw_drift)

#Calculate the first difference series
rw_drift_diff <- diff(rw_drift)
ts.plot(rw_drift_diff)

# Fit WN model to diff series
rwmodel <- arima(rw_drift_diff, order= c(0,0,0))


##ts.plot(rwmodel)

rwmodel$sigma2

# Get Time Series Data
tsdata <- as.ts(dmseries("http://data.is/1RvZGQL"))
ts.plot(tsdata)

# Reducing variability
tstrend <- log(tsdata)
ts.plot(tstrend)

# Remove Seasonality
tsdataseasonal <- diff(tsdata, lag = 12)
ts.plot(tsdataseasonal)


# ACF
ts.plot(tsdata)
acf(tsdata,plot = TRUE)

# PACF

pacf(tsdata,plot = TRUE)
  