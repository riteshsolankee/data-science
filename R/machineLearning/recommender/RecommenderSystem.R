library(recommenderlab) #Collaberative Filtering
library(reshape2)    #Alteration of data
library(ggplot2)     #visualization of results
#library(SNFtool)
# Read training file along with header
setwd("/Users/ritesh/pad-datascience/R/")
tr<-read.table(unz("machineLearning/recommender/data/train_v2.csv.zip", "train_v2.csv"), header=T, sep=",")
# Just look at first few lines of this file
head(tr)
#contains  ID, user, movie, rating as attributes
# Remove 'id' column. We do not need it
tr<-tr[,-c(1)]
# Check, if removed
tr[tr$user==1,]


g<-acast(tr, user ~ movie)

# Check the class of g
class(g)
# Convert it as a matrix
R<-as.matrix(g)
# Convert R into realRatingMatrix data structure
#   realRatingMatrix is a recommenderlab sparse-matrix like data-structure

r <- as(R, "realRatingMatrix")
# view r in other possible ways
as(r, "list")     # A list
as(r, "matrix")   # A sparse matrix
# I can turn it into data-frame
head(as(r, "data.frame"))
# normalize the rating matrix
r_m <- normalize(r)
as(r_m, "list")

# An image plot of raw-ratings & normalized ratings#  A column represents one specific movie and 
#ratings by users are shaded. 
#   Note that some items are always rated 'black' by most users while some items are not rated by many users  
#     On the other hand a few users always give high ratings as in some cases a series of black dots cut across 

image(r, main = "Raw Ratings")       
image(r_m, main = "Normalized Ratings")
r_b <- binarize(r, minRating=1) # Can also turn the matrix into a 0-1 binary matrix
as(r_b, "matrix")
# Create a recommender object (model)
#       They pertain to four different algorithms.
#        UBCF: User-based collaborative filtering
#        IBCF: Item-based collaborative filtering
#      Parameter 'method' decides similarity measure
#        Cosine or Jaccard
rec1=Recommender(r[1:nrow(r)],method="UBCF", param=list(normalize = "Z-score",method="Cosine",nn=5))
rec2=Recommender(r[1:nrow(r)],method="UBCF", param=list(normalize = "Z-score",method="Jaccard",nn=5))
#rec=Recommender(r[1:nrow(r)],method="IBCF", param=list(normalize = "Z-score",method="Jaccard"))
rec=Recommender(r[1:nrow(r)],method="POPULAR")

# Depending upon your selection, examine what you got
print(rec2)
names(getModel(rec2))
getModel(rec2)
#################Model in Action #####################
# recommended top 5 items for user u15348

recommended.items.u1022 <- predict(rec2, r["1022",], n=5)
                                          
# to display them
as(recommended.items.u1022, "list")
# to obtain the top 3
recommended.items.u1022.top3 <- bestN(recommended.items.u1022, n = 3)
# to display them
as(recommended.items.u1022.top3, "list")
################################################################

############Create predictions for the same user #############################
#to predict affinity to all non-rated items
recom <- predict(rec2, r["1022",], type="ratings")
# Convert all your recommendations to list structure
rec_list<-as(recom,"list")
as(recom, "matrix")[,1:10]
# Access this list. User 1, item at index 2
rec_list[[1]][2]
# Convert to data frame all recommendations for user 1
u1<-as.data.frame(rec_list[[1]])
attributes(u1)
class(u1)
head(u1)
# Create a column by name of id in data frame u1 and populate it with row names
u1$id<-row.names(u1)
# Now access movie ratings in column 2 for u1
u1[u1$id==3952,1]
u1[u1$id==3952,]
###############Validation#######################################
# create evaluation scheme splitting taking 90% of the data for training and leaving 10% for validation or test
e <- evaluationScheme(r[1:100], method="split", train=0.7, given=15)
# creation of recommender model based on ubcf
Rec.ubcf <- Recommender(getData(e, "train"), "UBCF")
# creation of recommender model based on ibcf for comparison
Rec.ibcf <- Recommender(getData(e, "train"), "IBCF")
# making predictions on the test data set
p.ubcf <- predict(Rec.ubcf, getData(e, "known"), type="ratings")
# making predictions on the test data set
p.ibcf <- predict(Rec.ibcf, getData(e, "known"), type="ratings")
# obtaining the error metrics for both approaches and comparing them
error.ubcf<-calcPredictionAccuracy(p.ubcf, getData(e, "unknown"))
error.ibcf<-calcPredictionAccuracy(p.ibcf, getData(e, "unknown"))
error <- rbind(error.ubcf,error.ibcf)
rownames(error) <- c("UBCF","IBCF")
error
####################################################################

########## Create submission File from model #######################
test<-read.csv("test_v2.csv",header=TRUE) # Read test file
head(test)
rec_list<-as(recom,"list") # Get ratings list
head(summary(rec_list))
ratings<-NULL
for ( u in 1:length(test[,2])) # For all lines in test file, one by one
{ userid <- test[u,2] # Read user and movie from columns 2 and 3 of test data
  movieid<-test[u,3]
  u1<-as.data.frame(rec_list[[userid]]) # Get as list & then convert to data frame all recommendations for userid
  u1$id<-row.names(u1)
  x= u1[u1$id==movieid,3] # Now access movie ratings in column 1 of u1
  if (length(x)==0)
  {    ratings[u] <- 0  }
  else
  {    ratings[u] <-x  }  }
length(ratings)
tx<-cbind(test[,1],round(ratings))
write.table(tx,file="submitfile.csv",row.names=FALSE,col.names=FALSE,sep=',') # Write to a csv file: #submitfile.csv in your folder

