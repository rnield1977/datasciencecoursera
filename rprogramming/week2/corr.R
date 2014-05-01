corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  source("corr.R")
  source("complete.R")
  cccount <- complete("specdata")
  sub <- subset(cccount, cccount$nobs > threshold) 
  names <- c("Date","sulfate","nitrate","ID")
  completemerge <- data.frame(Date=as.Date(character()),
                              sulfate=as.numeric(), 
                              nitrate=as.numeric(), 
                              ID=as.numeric()) 

  for (i in 1:332){
    
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
  
  #cc$corr <- cor(cc$sulfate,cc$nitrate)
  
  #ccsub <- subset(cc, sum(cc$ID) > threshold)
  mycorr <- vector()
  ccsub <- data.frame(id=as.numeric(),cor=as.numeric());
  for (i in sub$id){
    evalsub <- subset(cc, cc$ID == i)
    nobcor <- cor(evalsub$sulfate,evalsub$nitrate)
    row <- c(i,nobcor)
    ccsub <- rbind(ccsub,row)
    #print(cc[cc$ID == i,])
    
  }
  names <- c("id","cor")
  colnames(ccsub) <- names;
  
  #return(ccsub)
  mycorr <- ccsub$cor
  return(mycorr)
    
}




