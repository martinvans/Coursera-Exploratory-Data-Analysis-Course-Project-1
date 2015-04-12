## First we'll read the full data set from disk.
## Make sure the data set is in the 'Data' subdirectory of your working directory.
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
					  
## Set the date field to the right format. 
## Need to do this before subsetting the data on the date field.
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## I've chose to subset inside the R-script. 
## 
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## We can now remove the full data set to free up some memory.
rm(data_full)

## Create a datetime column from the date and time fields in the original data set.
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Create Plot 1 on the screen device.
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Copy the screen output to a PNG (bitmap) file in the working directory
dev.copy(png, file="plot1.png", height=480, width=480)

## Don't forget to turn off the graphics device.
dev.off()