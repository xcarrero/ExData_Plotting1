# Exploratory-Data-Analysis-Course-Project-1

# Rough estimate of memory required: ~300 Mb
# 2075259 records with 9 vars
# 1 10-byte/char var (date)
# 1  8-byte/char var (time)
# 7  8-byte vars (numbers)
reqMemMb <- 2075259*(10 + 8 + 7*8) / 2^20 * 2

# Load data - Just for two days
library(sqldf)
fileName <- "../household_power_consumption.txt"
fi <- file(fileName)
ds <- read.csv.sql(fileName,
                   sql = "select * from fi where Date in ('1/2/2007','2/2/2007')", 
                   header = TRUE,
                   sep = ";",
                   stringsAsFactors = FALSE,
                   nrows=10000)
close(fi)

# No 'NA' values (expressed as '?') present in the two days filtered above

# Convert variables
#ds$DateTime <- strptime(paste(ds$Date,ds$Time),"%d/%m/%Y %H:%M:%S")
ds$Time <- strptime(paste(ds$Date,ds$Time),"%d/%m/%Y %H:%M:%S")
ds$Date <- as.Date(ds$Date,"%d/%m/%Y")
ds$Global_active_power <- as.numeric(ds$Global_active_power)
ds$Global_reactive_power <- as.numeric(ds$Global_active_power)
ds$Voltage <- as.numeric(ds$Voltage)
ds$Global_intensity <- as.numeric(ds$Global_intensity)
ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)

# Plot
png(filename="plot1.png")
hist(ds$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     border="blue", 
     col="red")
     #xlim=c(100,700),
     #las=1, 
     #breaks=5)
dev.off()