NEI <- readRDS("C:/R/Exploratory Data Analysis/Project2/Data/summarySCC_PM25.rds")
SCC <- readRDS("C:/R/Exploratory Data Analysis/Project2/Data/Source_Classification_Code.rds")
library(plyr)
x<-ddply(NEI, .(year), summarize, sum = sum(Emissions))
png(filename = "C:/R/Exploratory Data Analysis/Project2/Plot1.png", width = 480, height = 480, units = "px")
plot(range(x$year),range(x$sum), xlab = "Year", ylab = "Total Emission (in tons)")
opt <- options(scipen = 10)
lines(x$year, x$sum, pch = "0")
dev.off()