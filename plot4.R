library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#4- Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?


SCC_coal<- SCC[grepl(".*[Cc]oal.*", SCC$EI.Sector), ]

SCC_coal_comb<-SCC_coal[grepl(".*[Cc]omb.*", SCC_coal$EI.Sector), ]

NEI_coal_comb<-filter(NEI,NEI$SCC %in% SCC_coal_comb$SCC)


emissions_coal_comb_NEI<-NEI_coal_comb%>%group_by(type,year)%>%
  summarize(total_emissions=sum(Emissions,na.rm = TRUE))


total_coal_comb_NEI<-emissions_coal_comb_NEI%>%group_by(year)%>%
  summarize(total_emissions=sum(total_emissions))%>%mutate(type="TOTAL")

total_coal_comb_NEI<-total_coal_comb_NEI%>%select(type,year,total_emissions)


merged_NEI<-rbind(as.data.frame(emissions_coal_comb_NEI),as.data.frame(total_coal_comb_NEI))

ggplot(merged_NEI, aes(x = factor(year), y = total_emissions))+geom_point(aes(color=type),size=3) +
  
  facet_grid(. ~ type)+labs(x="Year",y="Total emissions",
                            title="Change of emissions from coal combustion-related sources")


dev.copy(png, file="plot4.png")
dev.off()

