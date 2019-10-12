library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2- Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#(\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.

baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(baltimore_total_emissions = sum(Emissions,na.rm = TRUE))


with(baltimore,{plot(year,baltimore_total_emissions,xlab="Year",ylab="Total Emissions from PM2.5",
                     main="Annual Change in Tons of PM2.5 Emissions in Baltimore",cex=2,pch=4,lwd=2,
                     col=c(5,2,3,4),
                     ylim=c(1000,4000))
  lines(year,baltimore_total_emissions,lty=2,col=8)
})


axis(1,at=c(1999,2000,2001,2002,2003,2004,2005,2006,2007,2008))


dev.copy(png, file="plot2.png")
dev.off()

