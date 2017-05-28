install.packages("plumber")
library(plumber)

#data<-"38133,13037,13040"
#a=5
#b=5

#* @get /addData
addData <- function(a, b){
  
  a<-as.numeric(a)
  b<-as.numeric(b)
  print(a+b)
  
}


