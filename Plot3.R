setwd("C:/R/Exploratory Data Analysis/Project2/Data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

x<-subset(NEI, fips == "24510")

library(plyr)
a<-ddply(x, .(year, type), summarize, sum = sum(Emissions))

b<-subset(a, type == "NON-ROAD")
c<-subset(a, type == "NONPOINT")
d<-subset(a, type == "ON-ROAD")
e<-subset(a, type == "POINT")
z<-merge(x=b,y=c, by="year")
z<-merge(x=z,y=d, by="year")
z<-merge(x=z,y=e, by="year")

z[,2]<-NULL
z[,3]<-NULL
z[,4]<-NULL
z[,5]<-NULL

colnames(z)<-c("Year", "NONROAD", "NONPOINT", "ONROAD", "POINT")
png(filename = "C:/R/Exploratory Data Analysis/Project2/Plot3.png", width = 480, height = 480, units = "px")
ggplot(z, aes(x = Year)) + geom_line(aes(y = NONROAD), colour="blue") + geom_line(aes(y = NONPOINT), colour = "black") + geom_line(aes(y = ONROAD), colour = "green") + geom_line(aes(y = POINT), colour = "red") + ylab(label="PM TONS") + xlab("Year")
opt <- options(scipen = 10)
lines(x$year, x$sum, pch = "0")
dev.off()