
x <- matrix(
  1:12,
  ncol = 3,
  nrow = 2
)
y  <- matrix(
  5:30,
  ncol = 4,
  nrow = 3
  
)


matrixMultiplication <- function(x, y){
  if(ncol(x) != nrow(y)){
    print("Invalid input...")
  }else{
    print("multiplication can be done .....")
    x_row = nrow(x)
    y_col = ncol(y)
    x_col = ncol(x)
    result <- matrix(
      0:0,
      nrow = x_row,
      ncol = y_col
    )
    
    #print(result)
    for(r1 in 1:x_row){
      for(c2 in 1:y_col){
        for (c1 in 1:x_col) {
          result[r1,c2] <- (result[r1,c2] +  (x[r1,c1]*y[c1,c2] ))
        }
        
      }
      
    }
   #print(result)
  }
  result
}
