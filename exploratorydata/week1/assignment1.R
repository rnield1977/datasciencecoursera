#hpc <- read.csv(unz("exdata-data-household_power_consumption.zip","household_power_consumption.txt"), header=TRUE, sep=";")
#shpc <- subset(hpc, hpc$Date == '2007-02-02' | hpc$Date == '2007-02-01')

#Plot 1 
#hist(as.numeric(shpc$Global_active_power) / 500, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

#Plot 2

shpc$dat <- as.POSIXct(paste(shpc$Date, shpc$Time), format="%Y-%m-%d %H:%M:%S")
plot(shpc$dat, as.numeric(shpc$Global_active_power) / 500, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Plot 3
plot(shpc$dat, as.numeric(shpc$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
lines(shpc$dat, as.numeric(shpc$Sub_metering_1), col="gray", type="l")
lines(shpc$dat, as.numeric(shpc$Sub_metering_2), col="red", type="l")
lines(shpc$dat, as.numeric(shpc$Sub_metering_3), col="blue", type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("gray","red","blue"), lwd=1)

#Plot 4
plot(shpc$dat, as.numeric(shpc$Global_reactive_power) / 10000, ylab="Global_reactive_power", xlab="datetime", type="l", pch=19, cex=0.75)

#Add all together
par(mfrow=c(2,2))
#Plot 1 
hist(as.numeric(shpc$Global_active_power) / 500, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

#Plot 2

shpc$dat <- as.POSIXct(paste(shpc$Date, shpc$Time), format="%Y-%m-%d %H:%M:%S")
plot(shpc$dat, as.numeric(shpc$Global_active_power) / 500, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Plot 3
plot(shpc$dat, as.numeric(shpc$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
lines(shpc$dat, as.numeric(shpc$Sub_metering_1), col="gray", type="l")
lines(shpc$dat, as.numeric(shpc$Sub_metering_2), col="red", type="l")
lines(shpc$dat, as.numeric(shpc$Sub_metering_3), col="blue", type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("gray","red","blue"), lwd=1)

#Plot 4
plot(shpc$dat, as.numeric(shpc$Global_reactive_power) / 10000, ylab="Global_reactive_power", xlab="datetime", type="l", pch=19, cex=0.75)
