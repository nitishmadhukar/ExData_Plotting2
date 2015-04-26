library(ggplot2)
library(dplyr)

# Read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Data of emissions for Baltimore city based on the type
EmissionsByTypeBaltimore <- NEI %>% filter(fips == '24510') %>% group_by(year, type) %>% summarize(totalemissions = sum(Emissions))

# Plotting data
# Plotting the data for Emissions per year by type for Baltimore City
ggplot(data = EmissionsByTypeBaltimore, aes(x = year, y = totalemissions)) + geom_point(aes(color = type)) + geom_line(aes(color = type)) + labs(title = 'Emissions vs Year for each Type of Emission for Baltimore City') +  labs(x = 'Years') + labs(y = 'Emissions')
ggsave('plot3.png', width = 18, height = 14, units = 'cm')
