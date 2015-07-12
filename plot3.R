# note: change working directory to location of household_power_consumption.txt
# setwd("..")

data <- read.table(file="household_power_consumption.txt", sep=";", header=TRUE)

# format date into new col
data$FormatDate <- as.Date(strptime(data$Date,format="%d/%m/%Y"), "%m/%d/%Y")
df <- data[data$FormatDate %in% as.Date(c('2007-02-01', '2007-02-02')),]
df$DateTime <- as.POSIXct(paste(df$FormatDate, df$Time), format="%Y-%m-%d %H:%M:%S")

# cast data types
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# eunsure valid data for entire data frame 
plotdf <- df[is.numeric(df$Sub_metering_1) & !is.na(df$Sub_metering_1) & is.numeric(df$Sub_metering_2) & !is.na(df$Sub_metering_2) & is.numeric(df$Sub_metering_3) & !is.na(df$Sub_metering_3) , c("DateTime", "Global_active_power", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

png(filename = "plot3.png", width = 480, height = 480)

plot(Sub_metering_1 ~ DateTime, data=plotdf, type="l", xlab="", ylab="Energy sub metering")
lines(Sub_metering_2 ~ DateTime, data=plotdf,col="Red",type="l")
lines(Sub_metering_3 ~ DateTime, data=plotdf,col="Blue",type="l")
legend("topright", lty=1, col = c("black", "red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

