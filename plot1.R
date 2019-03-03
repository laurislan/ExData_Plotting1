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
powerConsump$Global_active_power <- as.numeric(powerConsump$Global_active_power)

png("plot1.png", width=480, height=480)
with(powerConsump, hist(powerConsump$Global_active_power, col="red",xlab="Global Active Power (kilowats)",main = "Global Active Power"))
dev.off() ## Close the PNG device
