

#Step 1: Load the training dataset

#Read in the Training set.
train <- read.csv ( "/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/digit_recognizer_data_train.csv")


# Create a 28*28 matrix with pixel color values
m = matrix(unlist(train[10,-1]), nrow = 28, byrow = TRUE)


# Plot that matrix
image(m,col=grey.colors(255))

# reverses (rotates the matrix)
rotate <- function(x) t(apply(x, 2, rev)) 
image(rotate(m),col=grey.colors(255))

#-----------------------------------------

#Step 2: Separate the dataset to 80% for training and 20% for testing

library (caret)
inTrain<- createDataPartition(train$label, p=0.8, list=FALSE)
training<-train[inTrain,]
testing<-train[-inTrain,]

#store the datasets into .csv files
#write.csv (training , file = "c:/digit/train-data.csv", row.names = FALSE) 
#write.csv (testing , file = "c:/digit/test-data.csv", row.names = FALSE)

# Clean env

training <- read.csv ("/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/digit_recognizer_data_train.csv") 
testing  <- read.csv ("/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/digit_recognizer_data_test.csv")

#-----------------------------------------

#Step 3: Load the h2o package

library(h2o)

#start a local h2o cluster
local.h2o <- h2o.init(ip = "localhost", port = 54321, startH2O = TRUE, nthreads=-1)

# convert digit labels to factor for classification
training[,1]<-as.factor(training[,1])

# pass dataframe from inside of the R environment to the H2O instance
trData<-as.h2o(training)
tsData<-as.h2o(testing)

#-----------------------------------------

#Step 4: Train the model
res.dl <- h2o.deeplearning(x = 2:785, y = 1, trData, activation = "Tanh", hidden=rep(160,10),epochs = 400)

#-----------------------------------------

#Step 5: Use the model to predict2

#use model to predict local testing dataset
pred.dl<-h2o.predict(object=res.dl, newdata=tsData[,-1])
pred.dl.df<-as.data.frame(pred.dl)

summary(pred.dl)
test_labels<-testing[,1]

#calculate number of correct prediction
sum(diag(table(test_labels,pred.dl.df[,1])))

#Step 6: Predict test.csv and submit to Kaggle
# read test.csv
test<-read.csv("/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/digit_recognizer_data_test.csv")

test_h2o<-as.h2o(test)

# convert H2O format into data frame and save as csv
pred.dl<-h2o.predict(object=res.dl, newdata=test_h2o[,-1])
df.test <- as.data.frame(pred.dl)
df.test <- data.frame(ImageId = seq(1,length(df.test$predict)), Label = df.test$predict)
write.csv(df.test, file = "/Users/ritesh/Documents/DataScience/advanceBigData/AdvancedML/submission2.csv", row.names=FALSE)

# shut down virtual H2O cluster
h2o.shutdown(prompt = FALSE)


