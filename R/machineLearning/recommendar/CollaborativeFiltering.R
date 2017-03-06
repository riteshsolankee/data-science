library(NMF)
x1 <- c(5,4,1,1) # get ratings for 5 users on 4 movies
x2 <- c(4,5,1,1)
x3 <- c(1,1,5,5)
x4 <- c(1,1,4,5)
x5 <- c(1,1,5,4)
R <- as.matrix(rbind(x1,x2,x3,x4,x5)) # n = 5 rows p = 4 columns 
set.seed(12345)

res <- nmf(R, 3,"lee") # lee & seung method
V.hat <- fitted(res) 
print(V.hat) # estimated target matrix


w <- basis(res) #  W  user feature matrix matrix
dim(w) # n x r (n= 5  r = 4)
print(w) 
h <- coef(res) # H  movie feature matrix
dim(h) #  r x p (r = 4 p = 4)
print(h) 
# recommendor system via clustering based on vectors in H
movies <- data.frame(t(h))
features <- cbind(movies$X1,movies$X2)
plot(features)
title("Movie Feature Plot")

