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

## Create Plot 4 on the screen device.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Reactive Power (kilowatts)",xlab="")
})


## Copy the screen output to a PNG (bitmap) file in the working directory
dev.copy(png, file="plot4.png", height=480, width=480)

## Don't forget to turn off the graphics device.
dev.off()