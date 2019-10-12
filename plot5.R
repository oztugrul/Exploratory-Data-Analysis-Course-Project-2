library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#5- How have emissions from motor vehicle sources changed from 1999 to 2008 in Baltimore City?

SCC_vehicle<- SCC[grepl("[Vv]eh.*", SCC$Short.Name), ]


NEI_vehicle<-filter(NEI,NEI$SCC %in% SCC_vehicle$SCC)


baltimore_vehicle_emissions<-NEI_vehicle%>%filter(fips=="24510")%>%group_by(year)%>%
  summarize(motor_vehicle_emissions=sum(Emissions,na.rm=TRUE))


ggplot(baltimore_vehicle_emissions, aes(year, motor_vehicle_emissions)) +geom_line(color="Dark Green",size=3)+
  
  labs(x="Year",y="Motor vehicle emissions",
       title="Annual emissions from motor vechicle-related sources in Baltimore")

dev.copy(png, file="plot5.png")
dev.off()

