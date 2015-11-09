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

plot(data$Date, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file = "plot2.png")
dev.off()
