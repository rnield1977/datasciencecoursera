pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
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
    completemerge <- rbind(completemerge,csv)
    
  }
  
  # Now filter the polutants
  #pSubset <- subset(complete, ID == id);
  #dim(pSubset)
  
  if (pollutant == "sulfate"){
    ret <- mean(completemerge$sulfate, na.rm = TRUE)
  }else if (pollutant == "nitrate"){
    ret <- mean(completemerge$nitrate, na.rm = TRUE)
  }
  return(ret)
  
}





 