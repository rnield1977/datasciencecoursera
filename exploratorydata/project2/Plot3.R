library(ggplot2)
NEI_Type <- aggregate(Emissions ~ year + type, NEI, sum)
nt <- ggplot(aes(year,Emissions),data=NEI_Type)
nt + geom_line() + facet_grid( . ~ type) + xlab("Years") + ggtitle("Total Emissions On Type")