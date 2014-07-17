NEI_sum <- aggregate(Emissions ~ year, NEI, sum)
plot(NEI_sum$year, NEI_sum$Emissions, type="l")
plot(NEI_sum$year, NEI_sum$Emissions, type="l", xlab="Year", ylab="Total Emissions")
title("Emissions by Year")