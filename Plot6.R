setwd("C:/R/Exploratory Data Analysis/Project2/Data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

ptn = "Motor+"
ndx = grep(ptn, SCC$Short.Name, perl=T)
a<-SCC[ndx,]
b<-merge(x = NEI, y = a, by = "SCC")
c<-subset(b, b$fips == "24510")
d<-subset(b, b$fips == "06037")

library(plyr)
x<-ddply(c, .(year), summarize, sum = sum(Emissions))
x<-transform(x, County = "Baltimore")
y<-ddply(d, .(year), summarize, sum = sum(Emissions))
y<-transform(y, County = "Los Angeles")

a<-matrix(x[,2],nrow=1,ncol=4)
colnames(a)<-x[,1]
rownames(a)<-c("Baltimore")
b<-matrix(y[,2],nrow=1,ncol=4)
colnames(b)<-y[,1]
rownames(b)<-c("Los Angeles")
a<-rbind(a,b)

png(filename = "C:/R/Exploratory Data Analysis/Project2/Plot6.png", width = 480, height = 480, units = "px")
barplot(a, beside=T, col=c("darkblue","red"), legend = rownames(a), xlab = "Year", ylab = "PM Tons")
opt <- options(scipen = 10)
lines(x$year, x$sum, pch = "0")
dev.off()