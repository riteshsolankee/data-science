x <- matrix(
  1:9,
  ncol = 3,
  nrow = 3
)

updateMatricValue <- function(row, col, pValue, pList){
  l_list <- pList
  l_list[[1]][row, col] <- pValue[pList[[2]]]
  l_list[[2]] <- l_list[[2]] + 1
  l_list
}

printDiagonal <- function(x, direction = 1){
  if(!is.null(nrow(x)) && !is.null(ncol(x))){
    message("Valid Input...")
    rowIndex <- 1
    colIndex <- 1
    values <- 1:(nrow(x) * ncol(x))
    y <- matrix(0, nrow = nrow(x), ncol = ncol(x))
    matrixList <- list(y,1)
    
    message("Printing diagonal starting from row")
    #message(x[rowIndex, colIndex])
    while(rowIndex != nrow(x) || colIndex != ncol(x)){
      if(colIndex == 1 && rowIndex == 1){
        #message(x[rowIndex, colIndex])
        matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
        if(direction == 1){
          colIndex <- colIndex + 1
        }else if(direction == 2){
          rowIndex <- rowIndex + 1
        }else{
          message("Invalide value for direction. Taking the default value as 1 to start from column")
          colIndex <- colIndex + 1
        }
      }else if(rowIndex == 1 && colIndex > 1 && colIndex <= ncol(x)){
        continue <- TRUE
        while(continue){
          #message(x[rowIndex, colIndex])
          matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
          if((rowIndex + 1) <= nrow(x) && (colIndex - 1) >= 1){
            rowIndex <- rowIndex + 1
            colIndex <- colIndex - 1
          }else{
            if((rowIndex + 1) > nrow(x)){
              colIndex <- colIndex + 1
            }
            if((colIndex - 1) < 1){
              rowIndex <- rowIndex + 1
            }
            continue <- FALSE
          }
        }
      }else if(colIndex == 1 && rowIndex > 1 && rowIndex <= nrow(x)){
        continue <- TRUE
        while(continue){
          #message(x[rowIndex, colIndex])
          matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
          if((colIndex + 1) <= ncol(x) && (rowIndex - 1) >= 1){
            colIndex <- colIndex + 1
            rowIndex <- rowIndex - 1
          }else{
            if((colIndex + 1) > ncol(x)){
              rowIndex <- rowIndex + 1
            }
            if((rowIndex - 1) < 1){
              colIndex <- colIndex + 1
            }
            continue <- FALSE
          }
        }
      }else if(colIndex > 1 && rowIndex > 1 && rowIndex == nrow(x)){
        continue <- TRUE
        while(continue){
          #message(x[rowIndex, colIndex])
          matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
          if((colIndex + 1) <= ncol(x) && (rowIndex - 1) >= 1){
            colIndex <- colIndex + 1
            rowIndex <- rowIndex - 1
          }else{
            if((colIndex + 1) > ncol(x)){
              rowIndex <- rowIndex + 1
            }
            if((rowIndex - 1) < 1){
              colIndex <- colIndex + 1
            }
            continue <- FALSE
          }
        }
      }else if(rowIndex > 1 && colIndex > 1 && colIndex == ncol(x)){
        continue <- TRUE
        while(continue){
          #message(x[rowIndex, colIndex])
          matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
          if((rowIndex + 1) <= nrow(x) && (colIndex - 1) >= 1){
            rowIndex <- rowIndex + 1
            colIndex <- colIndex - 1
          }else{
            if((rowIndex + 1) > nrow(x)){
              colIndex <- colIndex + 1
            }
            if((colIndex - 1) < 1){
              rowIndex <- rowIndex + 1
            }
            continue <- FALSE
          }
        }
      }
      #message("rowIndex: ", rowIndex," colIndex: ", colIndex)
      if(rowIndex == nrow(x) && colIndex == ncol(x)){
        #message(x[rowIndex, colIndex])
        matrixList <- updateMatricValue(rowIndex, colIndex, values, matrixList)
      }
    }
    print(matrixList[1])
  }else{
    message("Invalid Input ... First parameter should be Matrix")
  }
}
