# Run the probabilistic matrix factorization PMF based recommender system code on
# the matrix:A B C D E are books. u1 to u8 are users
#     A	B	C	D	E
# u1	3	2	1	3	3
# u2	3	3	3	4	4
# u3	3	2	4	2	4
# u4	3	4	2	3	2
# u5	4	4	2	3	2
# u6	2	2	4	2	4
# u7	2	2	2	2	2
# u8	4	3	4	4	2

# Probabilistic matrix factorization
library(NMF)

usr1 <- c(3, 2, 1, 3, 3)
usr2 <- c(3, 3, 3, 4, 4)
usr3 <- c(3, 2, 4, 2, 4)
usr4 <- c(3, 4, 2, 3, 2)
usr5 <- c(4, 4, 2, 4, 3)
usr6 <- c(2, 2, 4, 2, 4)
usr7 <- c(2, 2, 2, 2, 2)
usr8 <- c(4, 3, 4, 4, 2)

usrs <-
  as.matrix(rbind(usr1, usr2, usr3, usr4, usr5, usr6, usr7, usr8))

set.seed(9999)

# NMF - Non-negative Matrix Factorization
# Given a u x v matrix A with nonnegative elements, we wish to find nonnegative, 
# rank-k matrices W (u x k) and H (k x v) such that
# 
# A = WH
# 
# In other words, NMF is a form of dimension reduction.
# Using Lee & Seung method find target matrix
res <- nmf(usrs, 4, "lee")

usrs.hat <- fitted(res)
print(usrs.hat)

# User feature matrix
users_feature_matrix <- basis(res)
# Alternate way of accessing 
users_feature_matrix_W <- res@fit@W
# Dim: 8 x 4
dim(users_feature_matrix)
print(users_feature_matrix)
dim(users_feature_matrix_W)
print(users_feature_matrix_W)

# Book feature matrix
book_feature_matrix <- coef(res)
# Alternate way of accessing 
book_feature_matrix_H <- res@fit@H
# Dim: 4 x 5
dim(book_feature_matrix)
print(book_feature_matrix)

# recommender system via clustering based on vectors in book_feature_matrix
books <- data.frame(t(book_feature_matrix))

features <- cbind(books$X1, books$X2)

### 
plot(features)
title("Books Feature Plot")
