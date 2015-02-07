##code will read in a text file and plot the data from Global_active_power by frequency to show household energy usage for a 2-day period in February 2007

require(dplyr)

##create a vector for the classes and then read in the file assigning the classes in the read

vars<-c("character", "character", rep("numeric",7))
all_data<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", nrows=2075259, comment.char="", stringsAsFactors=FALSE, check.names=FALSE, colClasses=vars)

##subset the data to the dates requested

data<-all_data[all_data$Date %in% c("1/2/2007", "2/2/2007"),]
data<-tbl_df(data)

#create a variable that combines date and time
data$dateTime  <- as.POSIXlt(paste(as.Date(data$Date,format="%d/%m/%Y"), data$Time, sep=" "))

#plot data and create a png file

with(data, plot(dateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

dev.copy(png, width=480, height=480, file="plot2.png")
dev.off()
