require(devtools)
install_github('ramnathv/rcharts')
library(rCharts)

#Morris charts
data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1$print("chart2")

# create standalone chart with all assets included directly in the html file
m1$save('/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/morris.html', standalone = TRUE)


# the host defaults to 'gist'
m1$publish("morris")
m1$publish("morris", host = 'rpubs')

# More charts
#https://ramnathv.github.io/rCharts/



#-------------------------------------
install.packages("rsconnect")
library(rsconnect)
rsconnect::setAccountInfo(name="dataap", token="XXX", secret="XXX")
deployApp("app.R")



#-------------------------------------

library(plumber)
r <- plumb("/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/plum.R")  # Where 'plum.R' is the location of the file shown before
r$run(port=8000)
