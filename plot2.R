## EDA Course Project 1
## Plot 2

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
png("plot2.png", width=480, height=480)

# Make the exhibit.
plot(x = data_trimmed[, dateTime]
     , y = data_trimmed[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Dev off so you can see your exhibit.
dev.off()