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

##Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#top left
with(mod_data, plot(Date_Time, Global_active_power, xlab ="",
                    ylab = "Global Active Power", type = "l"))

#top right
with(mod_data, plot(Date_Time, Voltage, xlab ="datetime",
                    ylab = "Voltage", type = "l"))

#bottom left
with(mod_data, plot(Date_Time, Sub_metering_1, xlab ="",
                    ylab = "Energy sub metering", type = "l"))
with(mod_data, lines(Date_Time, Sub_metering_2, col = "red"))
with(mod_data, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

#bottom right
with(mod_data, plot(Date_Time, Global_reactive_power, xlab ="datetime",
                    ylab = "Global_reactive_power", type = "l"))
dev.off()