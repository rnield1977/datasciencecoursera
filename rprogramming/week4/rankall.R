rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
 
  
  states <- state.abb
  states <- c(states,'DC')
  states <- states[order(states)]
  
 
  
  

  result <- data.frame(hospital = character(), state = character())
  
  colnames(result) <- c("hospital","state")
  switch(outcome,
         'heart attack' = {
              
           for (state in states){
             substate <- subset(csv, csv$State == state)
             substate <- substate[!is.na(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
             if (num == "best"){
               fnum <- 1;
             } else if (num == "worst"){
               fnum <- nrow(substate)
               
             }
             else {
               fnum <- num
             }
             ordering <- order(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), substate$Hospital.Name)
             suboutcome <- substate[ordering,]
             insert <- data.frame(hospital=suboutcome[fnum], state=state)
             
             result <- rbind(result,insert)
                
           }
           
           
         },
         'heart failure' = {
           for (state in states){
             substate <- subset(csv, csv$State == state)
             substate <- substate[!is.na(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
             if (num == "best"){
               fnum <- 1;
             } else if (num == "worst"){
               fnum <- nrow(substate)
               
             }
             else {
               fnum <- num
             }
             ordering <- order(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),substate$Hospital.Name)
             suboutcome <- substate[ordering,]     
             insert <- data.frame(hospital=suboutcome[fnum,2], state=state)
             result <- rbind(result,insert)
           }
           
         },
         'pneumonia' = {
           
           for (state in states){
             substate <- subset(csv, csv$State == state)
             substate <- substate[!is.na(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
             if (num == "best"){
               fnum <- 1;
             } else if (num == "worst"){
               fnum <- nrow(substate)
               
             }
             else {
               fnum <- num
             }
             #print(fnum)
             
             ordering <- order(as.numeric(substate$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), substate$Hospital.Name)
             suboutcome <- substate[ordering,]
             
             #print(c(substate$Hospital.Name,substate$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
             rob <<- suboutcome
             insert <- data.frame(hospital=suboutcome[fnum,2], state=state)
             #print(suboutcome[fnum,2])
             
             #print(c(insert$hospital,insert$state,suboutcome[fnum,c(2,)]))
             
             result <- rbind(result,insert)
           }
          
         },{
           stop("invalid outcome")
         }
         
  )
  
  return(result)
  
  
}
