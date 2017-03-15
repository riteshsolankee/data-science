# For the Recommendation System done in the class, on data train_v2.csv
# find the top two similar users as user u1770 with Jaccard Distance.
# The training data contains four attributes: ID, user, movie and rating
getwd()
library(recommenderlab) #Collaberative Filtering
library(reshape2)    #Alteration of data
library(ggplot2)     #visualization of results

# Read training file along with header
tr<-read.table(unz("R/machineLearning/recommender/data/train_v2.csv.zip", "train_v2.csv"), header=T, sep=",")
# Just look at first few lines of this file
head(tr)

#contains  ID, user, movie, rating as attributes
# Remove 'id' column. We do not need it
tr<-tr[,-c(1)]
# Check, if removed
tr[tr$user==1,]

str(tr)
g<-acast(tr, user ~ movie)

# Convert it as a matrix
R<-as.matrix(g)
# Convert R into realRatingMatrix data structure
#   realRatingMatrix is a recommenderlab sparse-matrix like data-structure
r <- as(R, "realRatingMatrix")

#################Similarity##########################

## Run the cross similarity between user '1770' againt remaining all
user.simil <- similarity(r["1770"], r[1:nrow(r)], method="jaccard")
str(user.simil)
## Convert the similarity result to 'List'
user.simil.list <- as(user.simil, "list")

#### To validate if the similarity with self '1770' is maximum that is '1'
as(user.simil, "list")[[1770]]

## For extracting the top two similar users
user.simil.df <- data.frame(Reduce(rbind, user.simil.list))
user.simil.df$userId  <- 1:nrow(user.simil.df)
colnames(user.simil.df) <- c("similarity", "UsrId")
user.simil.df <- user.simil.df[ order(-user.simil.df[,1]), ]
## Print the top three similar records
head(user.simil.df, 3)
## Hence, the two most similar users are 861 and 4175

#View(user.simil.df)


#################End Similarity#####################
