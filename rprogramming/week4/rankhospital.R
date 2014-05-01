rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
   csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
   csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
   csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
   csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
   substate <- subset(csv, csv$State == state);
   csv <<- csv
   #bestoutcome <- subset(bestState, csv$)
   
   if (nrow(substate) == 0){
     stop("invalid state")
   }
   
   switch(outcome,
          'heart attack' = {
            substate <- substate[!is.na(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
            ordering <- order(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, substate$Hospital.Name)      
            substate <- substate[ordering,]
          },
          'heart failure' = {
            substate <- substate[!is.na(order(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
            #substate$ordered <- order(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, substate$Hospital.Name)
            ordering <- order(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,substate$Hospital.Name)
            
            substate <- substate[ordering,]
            
          },
          'pneumonia' = {
            substate <- substate[!is.na(substate$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
            ordering <- order(substate$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, substate$Hospital.Name)
            substate <- substate[ordering,]
          },{
            stop("invalid outcome")
          }
          
   )
   
   #print(ordered$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
   #print(ordered$Hospital.Name)
   
   if (num == "best"){
     num = 1;
   } else if (num == "worst"){
     num = as.numeric(nrow(substate))
     
   }
   else {
     num = num
   }
   
   #print(num)
   rob <<- substate[num,]
   
   myreturn <- substate[num,]
   
   #myreturn <- subset(substate, substate$ordered == num)
   
   #if (nrow(myreturn) == 0 ){
     #myreturn$Hospital.Name <- NA
   #}
   
   return(myreturn$Hospital.Name)
   
} 