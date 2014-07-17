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