complete <- function(directory, id = 1:332) {
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  names <- c("Date","sulfate","nitrate","ID")
 
  completemerge <- data.frame(Date=as.Date(character()),
                              sulfate=as.numeric(), 
                              nitrate=as.numeric(), 
                              ID=as.numeric()) 
  
  for (i in id){
    
    if (nchar(i) == 1){
      i = paste("00",i, sep = "");
    }else if (nchar(i) == 2){
      i = paste("0",i, sep = "");
    }
    csv <- read.csv(paste(directory,"/",i,".csv", sep = ""))
    if (nrow(csv) > 0){
      completemerge <- rbind(completemerge,csv)
    }
    
  }
  
  
  completecases <- complete.cases(completemerge);
  cc <- completemerge[completecases,]
  #names <- c("id","nobs");
  #library(plyr)
  
  ret <- data.frame(id=as.numeric(),nobs=as.numeric()); 

  for (i in id){
    
    row <- (c(i,sum(cc$ID == i)));
    #print(row)
    ret <- rbind(ret,row)
  }
  #ret <- colnames(names)
  #colnames(ret) <- names
  colnames(ret) <- c("id","nobs")
  
  return(ret)
}  