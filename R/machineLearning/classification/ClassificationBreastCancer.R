# Classification Tree with rpart
library(rpart)
library(caret)
setwd("/Users/ritesh/Documents/DataScience/machineLearning/regression")
bcTree <- read.csv("breast-cancer-wisconsin.csv")
breast_cancer_wisconsin_col_names <-
  c(
    "Sample_code_number",
    "Clump_Thickness",
    "Uniformity_of_Cell_Size",
    "Uniformity_of_Cell_Shape",
    "Marginal_Adhesion",
    "Single_Epithelial_Cell_Size",
    "Bare_Nuclei",
    "Bland_Chromatin",
    "Normal_Nucleoli",
    "Mitoses",
    "Class"
  )
colnames(bcTree) <- breast_cancer_wisconsin_col_names
str(bcTree)
## view the first few rows of the data
bcTree[bcTree == '?'] <- NA
bcTree <- na.omit(bcTree)

bcTree$Class <- as.numeric(bcTree$Class)
bcTree$Class[bcTree$Class == 2] <- 0
bcTree$Class[bcTree$Class == 4] <- 1
bcTree$Class <- as.factor(bcTree$Class)

trainIndex <-
  createDataPartition(
    y = bcTree$Class,
    p = .8,
    list = FALSE,
    times = 1
  )

head(trainIndex)

myDataTrain <- bcTree[trainIndex, ]
myDataTest <- bcTree[-trainIndex, ]

#To get the basic derivatives of data
summary(myDataTrain)

#to get the standard deviations of data
sapply(myDataTrain, sd)

#attach(myDataTrain)


## two-way contingency table of categorical outcome and predictors
## we want to make sure there are not 0 cells
xtabs( ~ Class + Clump_Thickness, data = myDataTrain)

#Logistic regression needs a categorical output variable

myDataTrain$rank <- factor(myDataTrain$Class)
fit <-
  rpart(
    Class ~ Clump_Thickness +
      Uniformity_of_Cell_Size + 
      Uniformity_of_Cell_Shape + 
      Marginal_Adhesion + 
      Single_Epithelial_Cell_Size +
      Bare_Nuclei +
      Bland_Chromatin +
      Normal_Nucleoli +
      Mitoses,
    method = "class",
    data = myDataTrain
  )
# grow tree
#fit <- rpart(Kyphosis ~ Age + Number + Start,
#            method="class", data=kyphosis)

View(myDataTrain)

printcp(fit) # display the results
plotcp(fit) # visualize cross-validation results
summary(fit) # detailed summary of splits

# plot tree
plot(fit, uniform = TRUE,
     main = "Classification Tree for marks")
text(fit,
     use.n = TRUE,
     all = TRUE,
     cex = .8)

# create attractive postscript plot of tree
post(fit, file = "c:/tree.ps",
     title = "Classification Tree for marks")
