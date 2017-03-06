
x<-read.csv("datafile.csv", header = TRUE, sep = ",")
head(x)
attach(x)
fit <-lm(Total...Irrigation.potential.created~Irrigation.potential.created...Rabi, data=x)
summary(fit)
fitted(fit)
plot(Total...Irrigation.potential.created~Irrigation.potential.created...Rabi, data=x, main="Indian-Irrigation")
abline(fit, col="red")

# diagnostic plots
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page
plot(fit)
detach(x)
