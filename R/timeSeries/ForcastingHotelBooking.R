## Forecast timeseries data
## 1. Load and visualize data
## 2. Make data stationary
## 3. Determining p,d & q using ACF and PACF
## 4. Validating fitting with 'aic', 'bic' and log likelihood 


library(rdatamarket)

# View the Data
tsdata <- as.ts(dmseries("http://data.is/1RvZGQL"))
### Visualize usng plot
ts.plot(tsdata)

### Step - 2
plot(log(tsdata))
plot(diff(log(tsdata)))

### Step - 3
acf(diff(log(tsdata)), lag.max = 50)
## Since first seasonal lag is positive, it suggest that we can go with AR
pacf(diff(log(tsdata)), lag.max = 50)
## Since second seasonal lag has sharp dip which suggest that we can go with AR

### Step - 4 
library(forecast)
fit <- arima(log(tsdata), c(1,1,0), seasonal = list(order=c(1,1,0), period = 12))


## Go for BIC if 'aic' does not show significant variation and take the one which has lower 
## 'BIC' value

BIC(arima(log(tsdata), c(1,1,1), seasonal = list(order=c(1,1,1), period = 12)))
BIC(arima(log(tsdata), c(0,1,1), seasonal = list(order=c(0,1,1), period = 12)))
BIC(arima(log(tsdata), c(1,1,0), seasonal = list(order=c(1,1,0), period = 12)))


############# Repeat above steps for Airpassenger ################
data("AirPassengers")

ap <- AirPassengers
ts.plot(ap)

plot(log(ap))
plot(diff(log(ap)))

acf(diff(log(ap)), lag.max = 50)
pacf(diff(log(ap)), lag.max = 50)
fit_ap <- arima(log(ap), c(0,1,1), seasonal = list(order=c(0,1,1), period = 12))
# BIC(arima(log(ap), c(1,1,0), seasonal = list(order=c(1,1,0), period = 12)))
# BIC(arima(log(ap), c(1,1,1), seasonal = list(order=c(1,1,1), period = 12)))
# BIC(arima(log(ap), c(0,1,1), seasonal = list(order=c(0,1,1), period = 12)))


pred <- predict(fit_ap, n.ahead=10*12)

ts.plot(ap, 2.718^pred$pred,  log="y",lty=c(1,3))

auto.arima(ap)
ets(ap)
