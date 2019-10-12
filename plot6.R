library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#6- Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
#in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037").

#Which city has seen greater changes over time in motor vehicle emissions?

SCC_vehicle<-SCC[grepl("[Vv]eh.*",SCC$Short.Name),]

NEI_vehicle<-filter(NEI,NEI$SCC %in% SCC_vehicle$SCC)

losangeles_vehicle_emissions<-NEI_vehicle%>%filter(fips=="06037")%>%group_by(year)%>%
  summarize(motor_vehicle_emissions=sum(Emissions,na.rm=TRUE))

losangeles_vehicle_emissions$city<-rep(c("losangeles"),4)

baltimore_vehicle_emissions$city<-rep(c("baltimore"),4)

two_city_emissions<-rbind(baltimore_vehicle_emissions,losangeles_vehicle_emissions)

ggplot(two_city_emissions,aes(year,motor_vehicle_emissions,color=city))+geom_point(size=4)+facet_grid(.~city)+labs(x="Year",y="Motor vehicle emissions",
                                                                                                                   title="Comparison of Baltimore and Los Angeles")

dev.copy(png, file="plot6.png")
dev.off()




