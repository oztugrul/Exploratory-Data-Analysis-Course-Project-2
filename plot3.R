library(dplyr)
library(ggplot2)


setwd("C:/Users/asus/Desktop/Exploratory Data Analysis/exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#3- Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad,

#nonroad) variable,which of these four sources have seen decreases in emissions from 1999 to 2008 for

#Baltimore City? Which have seen increases in emissions from 1999 to 2008? Use the ggplot2 plotting system

#to make a plot answer this question.



baltimore_with_type <- NEI %>% filter(fips == "24510") %>% group_by(type, year) %>%
  summarize(baltimore_tot_emission_with_type = sum(Emissions))


ggplot(baltimore_with_type, aes(x = factor(year), y =baltimore_tot_emission_with_type , fill = type)) +
  
  geom_bar(stat = "identity") + labs(x="Year",y="Total Emissions from PM2.5",
                                     title="Annual Change of Emissions in Baltimore by Source Type")+
  facet_grid(. ~ type)+scale_fill_brewer(palette="Spectral")


dev.copy(png, file="plot3.png")
dev.off()
