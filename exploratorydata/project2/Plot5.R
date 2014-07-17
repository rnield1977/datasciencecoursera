SCC_Vehicles <- SCC[grepl("Vehicles",SCC$EI.Sector),]
NEI_Baltimore_Vehicles <- sqldf(sprintf("SELECT * from NEI_Baltimore where SCC IN (\"%s\")",paste(SCC_Vehicles$SCC, collapse='","')))
NEI_Baltimore_Vehicles_Sums <- aggregate(Emissions ~ year, NEI_Baltimore_Vehicles, sum)
plot(NEI_Baltimore_Vehicles_Sums$year, NEI_Baltimore_Vehicles_Sums$Emissions, type="l", xlab="Year", ylab="Total Emissions For Vehicles in Boson")
