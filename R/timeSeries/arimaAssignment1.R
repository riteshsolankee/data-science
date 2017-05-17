##################### Assignment - 1 ###########################
### install and load libraries ######
## - 'forecast' - for Arima with drift
## - 'tseries' - Dickey-Fuller Test
## - 'stats' - for arima
library(tseries)
library(stats)
library(forecast)

### Load data
data(EuStockMarkets)

########   Step - 1: Understanding patterns   ##########
## DataType varification
## Data Summary
## Time series start and end detail
## Time series frequency
class(EuStockMarkets)
summary(EuStockMarkets)
head(EuStockMarkets)
start(EuStockMarkets)
end(EuStockMarkets)
frequency(EuStockMarkets) ## 52 weeks * 5 working day

### Checking sesonality
seasonplot(EuStockMarkets[,"DAX"])

### Analysing and Ploting trend
plot.ts(EuStockMarkets)
plot(aggregate(EuStockMarkets,FUN=mean))

## Plotting individually
plot(EuStockMarkets[,"DAX"])
plot(EuStockMarkets[,"SMI"])
plot(EuStockMarkets[,"CAC"])
plot(EuStockMarkets[,"FTSE"])

############ Conclusion from step - 1 #############
## 1 - Data is multivariate time series
## 2 - There are four time series data 
## 3 - Each time series have trend but no sesonality
## 4 - The frequence is 260

############ Step - 2: Stabilize variance #############
## Using 'log function' to stablize variwnce
plot.ts(log(EuStockMarkets))

data_log <- log(EuStockMarkets)

########### Step - 3: Detrending time series data
data_log_diff_1 <- diff(log(EuStockMarkets))
plot(data_log_diff_1)
## plotting 'DAX' time series
plot(data_log_diff_1[,"DAX"])

########### Since ARIMA can only handle univariae time series therefore,  
########### taking only 'DAX' time series for further arima forecastig analysis 
data_DAX <- EuStockMarkets[,"DAX"]
data_log_DAX <- log(data_DAX)

########## Step - 4: Manual model order selection ###########
## Make data stationary by using 'diff' and validae the level of stationarity by Dickey-Fuller Test
data_log_diff_1 <- diff(data_log_DAX)
plot(data_log_diff_1)
## Dickey-Fuller Test
adf.test(data_log_diff_1, alternative="stationary", k=0)
## Conclusion from Dickey fuller test
#   - First 'diff' makes the data stationary as p-value (0.01) is significantly low and hence null hypothesis is rejected ##
## Plot ACF and PACF graphs
acf(data_log_diff_1, lag.max = 600)
pacf(data_log_diff_1, lag.max = 600)
## Conclusion fron ACF and PACF 
#   - No log has crossed the significance boundary for both ACF and PACF 
#   - Hence p and q values an be taken as '0'
## Build model based on AIC (lower the better)
ar_0 <- arima(data_log_DAX,order=c(0,1,0))
ar_0 # autoregression term not significant
BIC(ar_0)
pred <- predict(ar, n.ahead=2*260)
ts.plot(data_DAX, 2.718^pred$pred,  log="y",lty=c(1,3))

## Trying to higher value of p and q  to see if AIC improves
ar_1 <- arima(data_log_DAX,order=c(1,1,0))
ar_1 # autoregression term not significant

ma_1 <- arima(data_log_DAX,order=c(1,1,0))
ma_1 # autoregression term not significant

## Conclusion 
# - Minimum AIC is achieved at p=0 and q = 0. AIC value = -11727.77
# - Also prediction is flat, therefore we need to  alos try with automatted algorithms

########### Step - 5: Usig automatted algorithm #############
auto.arima(data_log_DAX)

## Conclusion
#   - Auto arima also suggest (0,1,0) i.e p = 0 and q = 0 with one 'diff' but with drift as 'TRUE'

########## Step - 6: Trying Arima with drift as true ###########
ar_with_drift <- Arima(data_log_DAX,order=c(0,1,0), include.drift = T)
ar_with_drift # autoregression term not significant
data_log_DAX_forcast <- forecast(ar_with_drift, h= 5*260)
plot(data_log_DAX_forcast, main = "ARIMA forecasts for DAX", col = "Red")
