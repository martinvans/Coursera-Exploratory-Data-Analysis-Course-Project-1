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

## Create Plot 3 on the screen device.
## One line at a time.
with(data, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Copy the screen output to a PNG (bitmap) file in the working directory
dev.copy(png, file="plot3.png", height=480, width=850)

## Don't forget to turn off the graphics device.
dev.off()