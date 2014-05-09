

# Just reads the first 5 rows.
tab5 <- read.table("power.txt", header=TRUE, sep = ";", nrows=5)

# Get the classes of all the columns and store it in "classes" object.
classes <- sapply(tab5, class)

# Reads the data by skipping first 66636 rows. Then reads 2280 rows based on nrows arguement.
# Assign the column classes based on "classes" object above. Set na.strings value and name the columns using col.names.
# The subsetted data is then assigned to data frame called "initial".
initial <- read.table("power.txt", header=TRUE, sep = ";", colClasses=classes, 
                      col.names=names(tab5), na.strings = "?", skip=66636, nrows=2880)


#Converts the variable "Date" to "date" class.
initial$Date <- as.Date(initial$Date, "%d/%m/%Y")

# Formats the "Time" variable as required by strptime().
initial$Time <- paste(initial$Date, initial$Time)

# Converts the "Time" variable to "time" class using POSIX.
initial$Time <- as.POSIXlt(initial$Time)

# Opens the png graphic device with necessary background.
png(file="plot4.png", bg="transparent")

# Set the plot space and parameters for 2 rows and 2 columns ordering by row using "par".
par(mfrow = c(2, 2))

#Plots "Time" Vs "Global_active_power" as required with necessary settings.
plot(initial$Time, initial$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plots "Time" Vs "Voltage" as required with necessary settings.
plot(initial$Time, initial$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plots all the "Sub_Metering" values against "Time" variable with necessary settings and legend.
plot(initial$Time, initial$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(initial$Time, initial$Sub_metering_2, type="l", col="red")
lines(initial$Time, initial$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, bty="n", cex=0.9, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))


#Plots "Time" Vs "Global_reactive_power" as required with necessary settings.
plot(initial$Time, initial$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Close the graphic device.
dev.off()
