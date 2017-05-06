# Default
data()
print(EuStockMarkets)

# Getting Data into R from Data Market
install.packages("rdatamarket")
library(rdatamarket)

# View the Data
data <- dmlist("http://data.is/1RvZGQL")

# Is this data a time series Object ?

is.ts(data)

# Get Time Series Data
tsData <- as.ts(dmseries("http://data.is/1RvZGQL"))

# is this data a time series Object ?
is.ts(tsData)

#Time Series Object 
print(ts(tsData))

# Time Series first 10 observations 
head(tsData,10)

# Time series last 10 observations
tail(tsData,10)

# Time Series number of observations
length(tsData)

