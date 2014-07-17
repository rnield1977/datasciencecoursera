#Question 1
NEI_sum <- aggregate(Emissions ~ year, NEI, sum)
plot(NEI_sum$year, NEI_sum$Emissions, type="l")
plot(NEI_sum$year, NEI_sum$Emissions, type="l", xlab="Year", ylab="Total Emissions")
title("Emissions by Year")

#Question 2
NEI_Baltimore <- subset(NEI, fips == '24510')
NEI_Baltimore_sum <- aggregate(Emissions ~ year, NEI_Baltimore, sum)
plot(NEI_Baltimore_sum$year, NEI_Baltimore_sum$Emissions, type="l", xlab="Year", ylab="Total Emissions Baltimore")

#Question 3
library(ggplot2)
NEI_Type <- aggregate(Emissions ~ year + type, NEI, sum)
nt <- ggplot(aes(year,Emissions),data=NEI_Type)
nt + geom_line() + facet_grid( . ~ type) + xlab("Years") + ggtitle("Total Emissions On Type")

#Question 4
library(sqldf)
SCC_COAL_C <- sqldf("SELECT SCC FROM SCC where EI_Sector like '%Coal%' AND EI_Sector like '%Comb%'")
NEI_COAL_C <- sqldf(sprintf("SELECT * from NEI where SCC IN (%s)",paste(SCC_COAL_C$SCC, collapse=",")))
NEI_COAL_C_Sums <- aggregate(Emissions ~ year, NEI_COAL_C, sum)
plot(NEI_COAL_C_Sums$year, NEI_COAL_C_Sums$Emissions, type="l", xlab="Year", ylab="Total Emissions For Coal Combustion")

#Question 5
SCC_Vehicles <- SCC[grepl("Vehicles",SCC$EI.Sector),]
NEI_Baltimore_Vehicles <- sqldf(sprintf("SELECT * from NEI_Baltimore where SCC IN (\"%s\")",paste(SCC_Vehicles$SCC, collapse='","')))
NEI_Baltimore_Vehicles_Sums <- aggregate(Emissions ~ year, NEI_Baltimore_Vehicles, sum)
plot(NEI_Baltimore_Vehicles_Sums$year, NEI_Baltimore_Vehicles_Sums$Emissions, type="l", xlab="Year", ylab="Total Emissions For Vehicles in Boson")

#Question 6

SCC_Vehicles <- SCC[grepl("Vehicles",SCC$EI.Sector),]
NEI_Baltimore_Vehicles <- sqldf(sprintf("SELECT * from NEI_Baltimore where SCC IN (\"%s\")",paste(SCC_Vehicles$SCC, collapse='","')))
NEI_Baltimore_Vehicles_Sums <- aggregate(Emissions ~ year, NEI_Baltimore_Vehicles, sum)

NEI_California <- subset(NEI, fips == '06037')
NEI_California_Vehicles <- sqldf(sprintf("SELECT * from NEI_California where SCC IN (\"%s\")",paste(SCC_Vehicles$SCC, collapse='","')))
NEI_California_Vehicles_Sums <- aggregate(Emissions ~ year, NEI_California_Vehicles, sum)


minX = min(NEI_California_Vehicles_Sums$year, NEI_Baltimore_Vehicles_Sums$year)
minY = min(NEI_California_Vehicles_Sums$Emissions, NEI_Baltimore_Vehicles_Sums$Emissions)
maxX = max(NEI_California_Vehicles_Sums$year, NEI_Baltimore_Vehicles_Sums$year)
maxY = max(NEI_California_Vehicles_Sums$Emissions, NEI_Baltimore_Vehicles_Sums$Emissions)

plot(NEI_California_Vehicles_Sums$year, NEI_California_Vehicles_Sums$Emissions, xlim=c(minX, maxX), ylim=c(minY, maxY) ,col="blue", type="l", xlab="Year", ylab="Total Emissions For Vehicles in Boson vs California")
lines(NEI_Baltimore_Vehicles_Sums$year,NEI_Baltimore_Vehicles_Sums$Emissions, type="l", col="red")

