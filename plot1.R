
# Just reads the first 5 rows 
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
png (file = "plot1.png", bg="transparent")

# Plots a histogram of the "Global_active_power" with necessary settings.
hist(initial$Global_active_power, col = "red",
       xlab = "Globlal Active Power(kilowatts)", main = title("Global Active Power"))
#Close the graphic device.
dev.off() 
