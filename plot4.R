## EDA Course Project 1
## Plot 4

library("data.table")

# Download, unzip, and read in the data 
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"))
unzip(zipfile = "data.zip")
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Take a look at the data to make sure it unzipped correctly and is usable. 
head(data)

# Convert date and time format
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Trim and subset the data to the dates we want.  In this case, Feb 1-2, 2007.
data_trimmed <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

head(data_trimmed)

# Establish parameters and save file with appropriate title.
png("plot4.png", width=480, height=480)

# Set layout
par(mfrow=c(2,2))

# Make exhibit #1
plot(x = data_trimmed[, dateTime], y = data_trimmed[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power")

# Make exhibit #2
plot(data_trimmed[, dateTime],data_trimmed[, Voltage], type="l", 
     xlab="datetime", ylab="Voltage")

# Make exhibit #3
plot(data_trimmed[, dateTime], data_trimmed[, Sub_metering_1], type="l", 
     xlab="", ylab="Energy sub metering")
# Add color and legend
lines(data_trimmed[, dateTime], data_trimmed[, Sub_metering_2], col="red")
lines(data_trimmed[, dateTime], data_trimmed[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5)

# Make exhibit #4
plot(data_trimmed[, dateTime], data_trimmed[,Global_reactive_power], type="l", 
     xlab="datetime", ylab="Global_reactive_power", lwd = 1)

# Dev off so you can see your exhibit.
dev.off()