library(data.table)
# Download the file if it doesn't exist
fileName <- 'exdata_data_household_power_consumption.zip'
if(!file.exists(fileName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,fileName)
}

powerConData <- "household_power_consumption.txt"
object.size(powerConData)

# Unzips the file
if (!file.exists(powerConData)){unzip(fileName)}
powerConsump <- fread(powerConData)
powerConsump <- powerConsump[powerConsump$Date %in% c("1/2/2007","2/2/2007") ,]

datetime <- strptime(paste(powerConsump$Date, powerConsump$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Global_active_power <- as.numeric(powerConsump$Global_active_power)
Global_reactive_power <- as.numeric(powerConsump$Global_reactive_power)
Voltage <- as.numeric(powerConsump$Voltage)
Sub_metering_1 <- as.numeric(powerConsump$Sub_metering_1)
Sub_metering_2 <- as.numeric(powerConsump$Sub_metering_2)
Sub_metering_3 <- as.numeric(powerConsump$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
# 1
plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
# 2
plot(datetime, Voltage, type="l", xlab="", ylab="Voltage")
# 3
plot(datetime,Sub_metering_1,xlab = "", ylab="Energy sub metering",type = "n")
lines(datetime, Sub_metering_1, col = "black")
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4
plot(datetime, Global_reactive_power, type="l", xlab="", ylab="Global Reactive Power")
dev.off()
