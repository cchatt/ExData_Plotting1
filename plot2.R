# note: change working directory to location of household_power_consumption.txt
# setwd("..")

data <- read.table(file="household_power_consumption.txt", sep=";", header=TRUE)

# format date into a new column
data$FormatDate <- as.Date(strptime(data$Date,format="%d/%m/%Y"), "%m/%d/%Y")
df <- data[data$FormatDate %in% as.Date(c('2007-02-01', '2007-02-02')),]
df$DateTime <- as.POSIXct(paste(df$FormatDate, df$Time), format="%Y-%m-%d %H:%M:%S")

# cast data types
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

# eunsure valid data for entire data frame 
plotdf <- df[is.numeric(df$Global_active_power) & !is.na(df$Global_active_power), c("DateTime", "Global_active_power")]

png(filename = "plot2.png", width = 480, height = 480)

plot(Global_active_power ~ DateTime, data=plotdf, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

