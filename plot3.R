library(data.table)
library(tidyr)

#Set working directory to the parent folder of the
#"./household_power_consumption.txt" file.

##Read in data.
data <- fread("./household_power_consumption.txt", na.strings = "?")
subdata <- subset(data, Date == "2/2/2007" | Date == "1/2/2007")

##Format Date and Time columns.
mod_data <- unite_(subdata, "Date_Time", c("Date", "Time"), sep = " ")
mod_data$Date_Time <- as.POSIXct(strptime(mod_data$Date_Time, "%d/%m/%Y %H:%M:%S"))
class(mod_data$Date_Time)

##Plot 3
png(file = "plot3.png", width = 480, height = 480)
with(mod_data, plot(Date_Time, Sub_metering_1, xlab ="",
                    ylab = "Energy sub metering", type = "l"))
with(mod_data, lines(Date_Time, Sub_metering_2, col = "red"))
with(mod_data, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()