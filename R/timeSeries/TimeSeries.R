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

# Time Series Start of observation
start(tsData)

# Time Series Start of observation
end(tsData)

time(tsData)

# Return the time interval between obserations
deltat(tsData)

#Return the number of sample per unit time 
frequency(tsData)

# Return the positions in the cycle of each observation 
cycle(tsData)

#Calculate the sample Mean
mean(tsData)

# Get the value distrubution of the observations
summary(tsData)

# Visualize the Time Series
plot(tsData)

# Visualize and edit the time Series Axis manes
plot(tsData, xlab = "Yr-month", ylab="Bookings")

## Visualize and edit the time Series plotting thye (Dafaut type in "1")

plot(tsData, xlab="Yr-month", ylab = "Booking", type="b")

install.packages("forecast")
library("forecast")

#Visyalize seasonal plot
seasonplot(tsData, col=rainbow(13), year.labels = T)

# Visualize seasonal sub- series plot or month plot
monthplot(tsData)

