library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#1-Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 
#1999, 2002, 2005, and 2008.

head(NEI)
head(SCC)


annual_emissions_NEI<-NEI%>%filter(year==1999|2002|2005|2008)%>%group_by(year)%>%
  summarize(total_emissions=sum(Emissions,na.rm = TRUE))


with(annual_emissions_NEI,{plot(year,total_emissions,xlab="Year",ylab="Total Emissions from PM2.5",
                                
                                main="Annual Change in Tons of PM2.5 Emissions in the US",cex=2,pch=4,lwd=3,
                                col=c(5,2,3,4),
                                ylim=c(3000000,8000000))
  lines(year,total_emissions,lty=2,col=8)
})


axis(1,at=c(1999,2000,2001,2002,2003,2004,2005,2006,2007,2008))


dev.copy(png, file="plot1.png")
dev.off()

