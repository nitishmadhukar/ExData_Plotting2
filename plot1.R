library(dplyr)
# Read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data for total emissions per year
TotalEmissionsPerYear <- NEI %>% group_by(year) %>% summarize(totalemissions = sum(Emissions))

# Plotting data
# Creating a png file
png(file = 'plot1.png', width = 480, height = 480, bg = 'white')

# Plotting the data Total emissions per year
with(TotalEmissionsPerYear, plot(year, totalemissions, xlab = 'Years', ylab = 'Total Emissions', ylim = c(1e+06, 1e+07)))
with(TotalEmissionsPerYear, points(year, totalemissions, pch = 19))
with(TotalEmissionsPerYear, lines(year, totalemissions, type = 'l'))
with(TotalEmissionsPerYear, title(main = 'Total Emissions from All Sources vs Year'))

dev.off()
