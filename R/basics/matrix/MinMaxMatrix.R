
x <- matrix(
  floor(runif(20, min=0, max=101)),
  ncol = 4,
  nrow = 5
)

findMinAndMax <- function(x){
  if(!is.null(nrow(x)) && !is.null(ncol(x))){
    row <- nrow(x)
    col <- ncol(x)
    min <- x[1,1]
    max <- x[1,1]
    for (r in 1:row) {
      for(c in 1:col){
        if(max < x[r,c]){
          max <- x[r,c]
        }
        if(min > x[r,c]){
          min <- x[r,c]
        }
      }
      
    }
    message("Minumum value : ", min)
    message("Maximum value : ", max)
  }else{
    message("Imvalid Input....")
  }
}
