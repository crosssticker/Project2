setwd("C:/R/Exploratory Data Analysis/Project2/Data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

ptn = "Motor+"
ndx = grep(ptn, SCC$Short.Name, perl=T)
a<-SCC[ndx,]
b<-merge(x = NEI, y = a, by = "SCC")
c<-subset(b, b$fips == "24510")

library(plyr)
x<-ddply(c, .(year), summarize, sum = sum(Emissions))
png(filename = "C:/R/Exploratory Data Analysis/Project2/Plot5.png", width = 480, height = 480, units = "px")
plot(range(x$year),range(x$sum), xlab = "Year", ylab = "Total Emission (in tons)")
opt <- options(scipen = 10)
lines(x$year, x$sum, pch = "0")
dev.off()