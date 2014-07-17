SCC_COAL_C <- sqldf("SELECT SCC FROM SCC where EI_Sector like '%Coal%' AND EI_Sector like '%Comb%'")
NEI_COAL_C <- sqldf(sprintf("SELECT * from NEI where SCC IN (%s)",paste(SCC_COAL_C$SCC, collapse=",")))
NEI_COAL_C_Sums <- aggregate(Emissions ~ year, NEI_COAL_C, sum)
plot(NEI_COAL_C_Sums$year, NEI_COAL_C_Sums$Emissions, type="l", xlab="Year", ylab="Total Emissions For Coal Combustion") 