library(data.table)

# Where my git repo is, and my dataset
setwd("~/DataScienceCourse/4 Exploratory Data Analysis/project1")

# initialize the df 
rawdata <- read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")
headers <- colnames(rawdata)
data <- rawdata[as.Date(rawdata[,1], "%d/%m/%Y") == as.Date('2007-02-01') 
                | as.Date(rawdata[,1], "%d/%m/%Y") == as.Date('2007-02-02'),]
names(data) <- headers

# convert Date to date class
DateTime  <- paste(data$Date, data$Time)
data$Date <- as.POSIXct(DateTime,"%d/%m/%Y %H:%M:%S", tz="")

# 480x480 is the default for all the bitmap graphics devices
windows(480, 480)

par(mfcol=c(2,2))
# First: plot2.R
plot(data$Date, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)", main="")

# Second: plot3.R
plot(data$Date, data$Sub_metering_1, type="l", xlab="", ylab="Engergy sub metering", 
     main="")
points(data$Date, data$Sub_metering_2, type="l", col="red")
points(data$Date, data$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", pch="_", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Third
plot(data$Date, data$Voltage, type="l", xlab="datetime", 
     ylab="Voltage", main="")

# Fourth
plot(data$Date, data$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power", main="")

# save to a file and close graphics device
dev.copy(png, file = "plot4.png")
dev.off()
