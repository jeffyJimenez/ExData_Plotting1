# read dataframe, call it pData2 (for Power Data)
pData <- read.table("household_power_consumption.txt",
                 sep=";", header=TRUE, stringsAsFactors = FALSE)

# Only pick within the date range (only 2 days)
firstDay <- as.Date("2007-02-01", "%Y-%m-%d")
lastDay <- as.Date("2007-02-02", "%Y-%m-%d")

# subset the data to only the two days
# went from 2million+ to 2880 observations
pData2 <- subset(pData,
                    as.Date(Date, "%d/%m/%Y")>= firstDay &
                     as.Date(Date, "%d/%m/%Y")<= lastDay)

# convert each needed column to numeric
# they were all loaded as strings, need to change
pData2$Global_active_power <- as.numeric(pData2$Global_active_power)
pData2$Global_reactive_power <- as.numeric(pData2$Global_reactive_power)
pData2$Voltage <- as.numeric(pData2$Voltage)
pData2$Global_intensity <- as.numeric(pData2$Global_intensity)
pData2$Sub_metering_1 <- as.numeric(pData2$Sub_metering_1)
pData2$Sub_metering_2 <- as.numeric(pData2$Sub_metering_2)
pData2$Sub_metering_3 <- as.numeric(pData2$Sub_metering_3)

# lastly, we need a single column with the date and time together
# so that all the points are not lump in two days when graphing
pData2$datetime <- as.POSIXct(paste(pData2$Date, pData2$Time), format="%d/%m/%Y %H:%M:%S")


# Plot 1
png("plot1.png", width=480, height=480) # before plot
hist(pData2$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()

