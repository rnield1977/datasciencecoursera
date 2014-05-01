best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  bestState <- subset(csv, csv$State == state);
  #bestoutcome <- subset(bestState, csv$)
  
  if (nrow(bestState) == 0){
    stop("invalid state")
  }
  
  switch(outcome,
         'heart attack' = {
           resultrow <- subset(bestState, bestState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min(as.numeric(bestState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), na.rm=TRUE))
         },
         'heart failure' = {
           resultrow <- subset(bestState, bestState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min(as.numeric(bestState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), na.rm=TRUE))
         },
        'pneumonia' = {
          resultrow <- subset(bestState, bestState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == min(as.numeric(bestState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), na.rm=TRUE))
        }
    
  )
  
   
  
   if (nrow(resultrow) > 1){
    
     #resultrow <- resultrow[order(resultrow$Hospital.Name),]
     #res <- resultrow[1,]
     #resultrow <- res
     print(resultrow$Hospital.Name)
     print(resultrow$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
   }
  
   #print(resultrow)
   return(resultrow$Hospital.Name)
  
}