library(ggplot2)
library(dplyr)

# Read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data for Motor vehicle sources
SCCMobile <- SCC %>% filter(grepl('Mobile - On-Road', EI.Sector, ignore.case = T)) %>% select(SCC)

# Subsetting the data for Motor vehicle sources for Baltimore city
NEIMobile <- merge(NEI, SCCMobile, by = 'SCC')

# Data for Total Emissions for Baltimore city
EmissionsMotorBaltimoreLA <- NEIMobile %>% filter(fips == '24510' | fips == '06037') %>% group_by(year, fips) %>% summarize(totalemissions = sum(Emissions)) %>% rename(place = fips)
EmissionsMotorBaltimoreLA$place <- factor(EmissionsMotorBaltimoreLA$place, levels = c('24510', '06037'), labels = c('Baltimore', 'LA'))

# Plotting data for Emissions for Baltimore city and Los Angeles County
ggplot(data = EmissionsMotorBaltimoreLA, aes(x = year, y = totalemissions, type = place)) + geom_point(aes(color = place)) + geom_line(aes(color = place)) + labs(title = 'Emissions vs Year of Motor Vehicles for Baltimore and LA') + labs(x = 'Years') + labs(y = 'Emissions') 
ggsave('plot6.png', width = 15, height = 14, units = 'cm')
