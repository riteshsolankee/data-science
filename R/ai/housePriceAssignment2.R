### Deleting all variables 
rm(list=ls())

### Install and load libraries
library(data.table)
library(caret)
library(Boruta)

### Set the working directory
setwd("/Users/ritesh/pad-datascience/R/")

### Load data and intial analysis
train <- read.csv("ai/data/train.csv", stringsAsFactors = T)
test <- read.csv("ai/data/test.csv", stringsAsFactors = T)

str(train)
str(test)
names(train)
names(test)
# Description:
# The Ames Housing dataset was retrieved from https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data. 
# The dataset represents residential properties in Ames, Iowa from 2006 to 2010. There is a train and a test file. 
# The train file has 1460 observations and the test file has 1459 observations. Train dataset contain 81 and test dataset contain 
# 80 explanatory variables composed of 46 categorical and 33 continuous variables that describe house features such as neighborhood, 
# square footage, number of full bathrooms, and many more. The train file contains a response variable column, SalePrice, 
# which is what we will predict in the test set. There is also a unique ID for each house sold, but were not used in fitting 
# the models.

### Feature select (using Boruta) ###
# Clear variables
rm(list=ls())

# Load data afresh  
# retrive data for analysis
sample.df <- read.csv("ai/data/train.csv", stringsAsFactors = F)
# extract only candidate feature names i.e exclude 'ID' and lable column
candidate.features <- setdiff(names(sample.df),c("Id","SalePrice"))
data.type <- sapply(candidate.features,function(x){class(sample.df[[x]])})
table(data.type)

# Determine data types
explanatory.attributes <- setdiff(names(sample.df),c("Id","SalePrice"))
data.classes <- sapply(explanatory.attributes,function(x){class(sample.df[[x]])})

# categorize data types in the data set?
unique.classes <- unique(data.classes)

attr.data.types <- lapply(unique.classes,function(x){names(data.classes[data.classes==x])})
names(attr.data.types) <- unique.classes

# Prepare data set for Boruta analysis. As Boruta uses Random forest, missng data needs to be fixed
# pull out the response variable
response <- sample.df$SalePrice

# remove identifier and response variables
sample.df <- sample.df[candidate.features]

# for numeric set missing values to -1 for purposes of the random forest run
for (x in attr.data.types$integer){
  sample.df[[x]][is.na(sample.df[[x]])] <- -1
}
# for charater set missing values to *MISSING* for purposes of the random forest run
for (x in attr.data.types$character){
  sample.df[[x]][is.na(sample.df[[x]])] <- "*MISSING*"
}

### Run Boruta Analysis ###
set.seed(13)
bor.results <- Boruta(sample.df,response,
                      maxRuns=101,
                      doTrace=0)

# Print Boruta result
bor.results
## Relevant Attributes:
getSelectedAttributes(bor.results, withTentative = F)

### plot the boruta variable importance chart.
# Blue boxplots correspond to minimal, average and maximum Z score of a shadow attribute. Red, yellow and green boxplots 
# represent Z scores of rejected, tentative and confirmed attributes respectively.
plot(bor.results, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(bor.results$ImpHistory),function(i)bor.results$ImpHistory[is.finite(bor.results$ImpHistory[,i]),i])
names(lz) <- colnames(bor.results$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels), at = 1:ncol(bor.results$ImpHistory), cex.axis = 0.7)


#########   ------  ###############
#final.boruta <- TentativeRoughFix(bor.results)
#plot(final.boruta, xlab = "", xaxt = "n")
#lz<-lapply(1:ncol(final.boruta$ImpHistory),function(i)final.boruta$ImpHistory[is.finite(final.boruta$ImpHistory[,i]),i])
#names(lz) <- colnames(final.boruta$ImpHistory)
#Labels <- sort(sapply(lz,median))
#axis(side = 1,las=2,labels = names(Labels), at = 1:ncol(final.boruta$ImpHistory), cex.axis = 0.7)
#########   ------  ###############

attStats(bor.results)




####### STEP _ : Explore the Data and handle Missing Values #########

### Data Cleansing
Num_NA<-sapply(train,function(y)length(which(is.na(y)==T)))
NA_Count<- data.frame(Item=colnames(train),Count=Num_NA)
str(NA_Count)



