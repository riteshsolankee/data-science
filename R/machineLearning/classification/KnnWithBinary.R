library(class)
library(gmodels)

#normalize data
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) }

data <- read.csv("binary.csv")
attach(data)
mydata <- as.data.frame(lapply(data[2:3], normalize))

myNewData <- cbind(admit, mydata, rank)


myDatatrainIndex <- createDataPartition(y=myNewData$admit, p=.8, list=FALSE, times=1)


myDataTrain <- myNewData[myDatatrainIndex,]
myDataTest <- myNewData[-myDatatrainIndex,]  

myDataTrain_labels <- data[1:nrow(myDataTrain),1]
#myDataTest <- myDataTest[,-c(1,6,7)]
myDataTest_labels <- data[1:nrow(myDataTest),1]






myData_pred <- knn(train = myDataTrain, test = myDataTest,cl=myDataTrain_labels, k=20)

CrossTable(x=myDataTest_labels, y=myData_pred, prop.chisq=FALSE)

