# analysis.R
# Written by: Robert Nield
# Date: 5/24/2014

# Function: merge data
# Parameters: 1 and 2 Datatableds
# Desscription: Bind 2 datatables together
library(plyr)
mergeData <- function(dt1,dt2){
  return(rbind(dt1,dt2))
} 


# Function: getData
# Parameter: dir is the subdirectory
# Parameter: x is the filename
# Description: Read the different dataset files
getData <-  function(dir,x){
  return(read.table(paste0(dir,"/",x)))
}

# Function: getMeanAndStdD
# Paramter: features is the list of columns for the dataset
# Paramter: X is the dataset with the columns
# Description: Create a subset of the data which has just the Mean and STD

getMeanAndStdD <- function(features,X){
  xmeancol <- grep('mean\\(\\)',features[,2])
  xsd <- grep('std\\(\\)',features[,2])
  submean <- X[,c(xmeancol,xsd)]
  return(submean)
}

# Function: loadData
# Description: Loads the data for each dataset.

loadData <- function(){
  if (!exists("mergedX")){
    trainingX <- getData("test","X_test.txt")
    testingX  <- getData("train","X_train.txt") 
    mergedX   <<- mergeData(trainingX,testingX)
  }
  if (!exists("mergedY")){
    trainingY <- getData("test","y_test.txt")
    testingY  <- getData("train","y_train.txt")
    mergedY   <<- mergeData(trainingY,testingY)
  }
  if(!exists("subject")){
    
    subject_train <- getData("train","subject_train.txt")
    subject_test <- getData("test","subject_test.txt")
    colnames(subject_train) <- "subject"
    colnames(subject_test) <- "subject"
    subject <<- mergeData(subject_train,subject_test)
  }  
}

# Function: getActivities
# Parameter: of the Activity datasets
# Description: Sets the activities to the dataset


getActivities <- function(Y){
  colnames(Y) <- "activity"
  Y$activity[Y$activity == 1] = "Walking"
  Y$activity[Y$activity == 2] = "Walking_Upstairs"
  Y$activity[Y$activity == 3] = "Walking_Downstairs"
  Y$activity[Y$activity == 4] = "Sitting"
  Y$activity[Y$activity == 5] = "Standing"
  Y$activity[Y$activity == 6] = "Laying"
  return(Y)
}


 
loadData() 
features <- getData("./","features.txt")
colnames(mergedX) <- features[,2]
subMergeX <- getMeanAndStdD(features,mergedX) 
yActivities <- getActivities(mergedY)
tidystage1 <- cbind(subMergeX,yActivities,subject)
UCI_Tidy_Dataset <- ddply(tidystage1, .(subject, activity), function(x) colMeans(x[,1:66]))
write.csv(UCI_Tidy_Dataset, "tidy.txt", row.names=FALSE) 
  