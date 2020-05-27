# Checking if folder already exists in wd. If not, downloads and unzip
if (!file.exists("household_power_consumption.txt")) { 
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip", method = "curl")
        unzip("data.zip")
}        

# Calls plyr and lubridate
library(plyr)
library(lubridate)

# Only reads relevant data (from 2007-02-01 to 2007-02-02)
data2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intesity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), skip = 66636, nrows = 2880)
# Creates a new column with the date and time as one variable and change class of date_time to POSIXct
data3 <- mutate(data2, date_time = dmy_hms(paste(as.character(Date), as.character(Time))))
# Open png file
png("plot2.png", width = 480, height = 480)
# plot number 2
plot(data3$date_time, data3$Global_active_power, type = "l" , ylab = "Global Active Power (kilowwats)", xlab = "")
# close device
dev.off()