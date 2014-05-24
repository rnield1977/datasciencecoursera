# This is reading the XML

#Question 4

library(XML)
fileURL <- "getdata-data-restaurants.xml"
doc <- xmlTreeParse(fileURL, useInternal=TRUE) 
rootNode <- xmlRoot(doc)
#print(rootNode)
# print(xmlSApply(rootNode,xmlValue))
zip <- xpathSApply(rootNode,"//zipcode[text() = '21231']",xmlValue)
summary(zip)


#Question 5
system.time(replicate(100,sapply(split(DT$pwgtp15,DT$SEX),mean)))
system.time(replicate(100,tapply(DT$pwgtp15,DT$SEX,mean)))

