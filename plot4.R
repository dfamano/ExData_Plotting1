# Checking if folder already exists in wd. If not, downloads and unzip
if (!file.exists("household_power_consumption.txt")) { 
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip", method = "curl")
        unzip("data.zip")
}        

# Calls plyr and lubridate
library(plyr)
library(lubridate)

# Only reads relevant data (from 2007-02-01 to 2007-02-02)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intesity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), skip = 66636, nrows = 2880)
# Creates a new column with the date and time as one variable and change class of date_time to POSIXct
data_plot <- mutate(data, date_time = dmy_hms(paste(as.character(Date), as.character(Time))))
# Open png file
png("plot4.png", width = 480, height = 480)
# Make mfrow
par(mfrow=c(2,2))
# plot number 1
plot(data_plot$date_time, data_plot$Global_active_power, type = "l" , ylab = "Global Active Power", xlab = "")
# plot number 2
plot(data_plot$date_time, data_plot$Voltage , type = "l" , ylab = "Voltage", xlab = "datetime")
# plot number 3
plot(data_plot$date_time, data_plot$Sub_metering_1 , type = "l" , xlab = "", ylab = "Energy sub metering", col = "black")
lines(data_plot$date_time, data_plot$Sub_metering_2, col = "red")
lines(data_plot$date_time, data_plot$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")
# plot number 4
plot(data_plot$date_time, data_plot$Global_reactive_power , type = "l" , ylab = "Global_reactive_power", xlab = "datetime")
# close device
dev.off()