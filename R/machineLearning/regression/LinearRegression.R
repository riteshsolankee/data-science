
setwd("/Users/ritesh/pad-datascience/R/")
x<-read.csv("machineLearning/data/datafile.csv", header = TRUE, sep = ",")
head(x)
attach(x)
fit <-lm(Total...Irrigation.potential.created~Irrigation.potential.created...Rabi, data=x)
summary(fit)
fitted(fit)
plot(Total...Irrigation.potential.created~Irrigation.potential.created...Rabi, data=x, main="Indian-Irrigation")
abline(fit, col="red")

## Cross validation using DAAG
predict(fit, x[,1])

install.packages("DAAG")
library(DAAG)

cv.lm(x, form.lm = formula(Total...Irrigation.potential.created ~ Irrigation.potential.created...Rabi))

