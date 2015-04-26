library(dplyr)
# Read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data for Total emissions per year for Baltimore city
TotalEmissionsPerYearBaltimore <- NEI %>% filter(fips == '24510') %>% group_by(year) %>% summarize(totalemissions = sum(Emissions))

# Plotting data
# Creating a png file
png(file = 'plot2.png', width = 480, height = 480, bg = 'white')

# Plotting the data Total emissions per year for Baltimore city
with(TotalEmissionsPerYearBaltimore, plot(year, totalemissions, xlab = 'Years', ylab = 'Total Emissions', ylim = c(1000, 5000)))
with(TotalEmissionsPerYearBaltimore, points(year, totalemissions, pch = 19))
with(TotalEmissionsPerYearBaltimore, lines(year, totalemissions, type = 'l'))
with(TotalEmissionsPerYearBaltimore, title(main = 'Total Emissions vs Year for Baltimore City'))

dev.off()
