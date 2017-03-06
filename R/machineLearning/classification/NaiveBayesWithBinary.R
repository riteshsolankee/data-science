setwd("/Users/ritesh/Documents/DataScience/machineLearning/4feb")

library(e1071)
library(caret)

#mydata <- read.csv("binary.csv")
mydata<-read.csv("Indian-liver-patients.csv", header = TRUE, sep = ",")
View(mydata)

trainIndex <- createDataPartition(y=mydata$Liver.patient.or.not, p=.8, list=FALSE, times=1)

head(trainIndex)

myDataTrain <- mydata[trainIndex,]
myDataTest <- mydata[-trainIndex,]

#To get the basic derivatives of data
summary(myDataTrain)

#to get the standard deviations of data
sapply(myDataTrain, sd)

attach(myDataTrain)

## two-way contingency table of categorical outcome and predictors
## we want to make sure there are not 0 cells
xtabs(~ Liver.patient.or.not + Gender.of.the.patient, data = myDataTrain)

#Classification needs a categorical output variable

myDataTrain$Gender.of.the.patient <- factor(myDataTrain$Gender.of.the.patient)
myDataTrain$Liver.patient.or.not <- factor(myDataTrain$Liver.patient.or.not)
levels(myDataTest) <- levels(myDataTrain)


attach(myDataTrain)

modelNB <- naiveBayes(Liver.patient.or.not ~ ., data = myDataTrain)

tt=table(predict(modelNB, myDataTest[,-11]),myDataTest$Liver.patient.or.not)

acc=sum(diag(tt))/sum(tt)
acc


curve(dnorm(x,6.55, 1.05), add=T, col="blue")
plot(function(x) dnorm(x,0.9, 0.3),0,2, col="black")

plot(function(x) dnorm(x,45.647, 15.65),0,91.2, col="black")
