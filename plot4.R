library(ggplot2)
library(dplyr)

# Read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data for emissions from coal combustion related source
# Retriving the SCC values pertaining to Coal combustion
SCCCoal <- SCC %>% filter(grepl('Coal', EI.Sector, ignore.case = T)) %>% select(SCC)

# Subsetting the data from NEI pertaining to Coal combustion
NEICoal <- merge(NEI, SCCCoal, by = 'SCC')

# Data for total emissions per year for coal combustions
NEICoal <-  NEICoal %>% group_by(year) %>% summarize(totalemissions = sum(Emissions))

# Plotting data for Total Emissions of Coal Combustions per year
ggplot(data = NEICoal, aes(x = year, y = totalemissions)) + geom_point(color = 'Red', size = 3) + geom_line() + labs(title = 'Emissions vs Year for Coal Combustion Related Sources') +  labs(x = 'Years') +  labs(y = 'Emissions')
ggsave('plot4.png', width = 18, height = 14, units = 'cm')
