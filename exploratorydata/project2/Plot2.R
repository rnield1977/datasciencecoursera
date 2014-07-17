NEI_Baltimore <- subset(NEI, fips == '24510')
NEI_Baltimore_sum <- aggregate(Emissions ~ year, NEI_Baltimore, sum)
plot(NEI_Baltimore_sum$year, NEI_Baltimore_sum$Emissions, type="l", xlab="Year", ylab="Total Emissions Baltimore")