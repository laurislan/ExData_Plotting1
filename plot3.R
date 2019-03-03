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
Sub_metering_1 <- as.numeric(powerConsump$Sub_metering_1)
Sub_metering_2 <- as.numeric(powerConsump$Sub_metering_2)
Sub_metering_3 <- as.numeric(powerConsump$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime,Sub_metering_1,xlab = "", ylab="Energy sub metering",type = "n")
lines(datetime, Sub_metering_1, col = "black")
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()