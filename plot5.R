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
EmissionsMotorBaltimore <- NEIMobile %>% filter(fips == '24510') %>% group_by(year) %>% summarize(totalemissions = sum(Emissions))

# Plotting data for total Emisssion of Motor vehicles for Baltimore city
ggplot(data = EmissionsMotorBaltimore, aes(x = year, y = totalemissions)) + geom_point(size = 3, color = 'Red') + geom_line() + labs(title = 'Emissions vs Year of Motor Vehicles for Baltimore city') + labs(x = 'Years') + labs(y = 'Emissions')
ggsave('plot5.png', width = 18, height = 14, units = 'cm')
