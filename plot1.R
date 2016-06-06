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

##Plot 1
png(file = "plot1.png", width = 480, height = 480)
hist(mod_data$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()