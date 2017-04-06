# Classification Tree with rpart
library(rpart)
library(caret)

setwd("/Users/ritesh/pad-datascience/R/")
mydata <- read.csv("machineLearning/data/binary.csv")

head(mydata)
## view the first few rows of the data
trainIndex <- createDataPartition(y=mydata$admit, p=.8, list=FALSE, times=1)

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
xtabs(~ admit + rank, data = myDataTrain)

# Convert the rank field to categorical output variable
myDataTrain$rank <- factor(myDataTrain$rank)
fit <- rpart( admit ~ gre + gpa + rank, method="class", data=myDataTrain)
# grow tree 
#fit <- rpart(Kyphosis ~ Age + Number + Start,
 #            method="class", data=kyphosis)

head(myDataTrain)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

levels(myDataTrain$rank) <- levels(myDataTest$rank)

myDataTest$rank <- factor(myDataTest$rank)

myDataTest$myDataOutput <- predict(fit, myDataTest, type="class")

#Confusion Matrix
predict.output.tree <-(myDataTest$myDataOutput)
actual.input.tree <- myDataTest$admit
conf.tablr <- table(predict.output.tree, actual.input.tree)
confusionMatrix(conf.tablr)


# plot tree 
plot(fit, uniform=TRUE, 
     main="Classification Tree for marks")
text(fit, use.n=TRUE, all=TRUE, cex=.8)


