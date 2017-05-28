### Set the working directory
setwd("/Users/ritesh/pad-datascience/R/")

### Load data
train <- fread("ai/data/train.csv", stringsAsFactors = T)
test <- fread("ai/data/test.csv", stringsAsFactors = T)


####### STEP 1 : Explore the Data and handle Missing Values #########