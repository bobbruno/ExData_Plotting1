######################################################################################
#
# Plot4.R: Generates multiple lineplots
#
# By Roberto Bruno Martins (bobbruno@github.com)
#
# For the John Hopkins Data Science Track "Exploratory Data Analysis" course project 1
#
######################################################################################


# If the dataframe is already loaded, let's not waste time doing it all again!
if (!exists(df)) {
    # Reads the datafile. Assumes that the datafile is in the current directory.
    # Notice that the datafile was not pushed to the git repository due to its size
    # Uses read.csv2 because it assumes ";" as field separator. nrows was added 
    # to make loading faster.
    df = read.csv2("./household_power_consumption.txt", dec=".", nrows=2075260,
                   na.strings = "?", header=TRUE, stringsAsFactors=FALSE)
    
    # Transforming times to internal format
    df$Time = strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
    # Transforming dates to internal format
    df$Date = as.Date(df$Date, "%d/%m/%Y")
    
    # Since we only need these 2 days, throw the rest away - performance and resource gains
    df = subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
}

# en_US is not my default locale. I had to set this in order to get the weekday labels
# correctly in english.
Sys.setlocale("LC_TIME", 'en_US.UTF-8')


# Define the graph grid of 2x2 plots
par(mfrow=c(2,2), cex=0.65)

# Create the 1st line graph.
with(df, plot(x=Time, y=Global_active_power, type="l", xlab="",
              ylab="Global Active Power"))

# Create the 2nd plot, voltage x time.
with(df, plot(x=Time, y=Voltage, type="l",
              xlab="datetime", ylab="Voltage"))

# Create the 3rd plot, similar to plot3.R
plot(x= df$Time, y=df$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering", col="black")
# Adds the second submeter
lines(x=df$Time, y=df$Sub_metering_2, type="l",col="red")
# Adds the third submeter
lines(x=df$Time, y=df$Sub_metering_3, type="l",col="blue")
# Adds the legend
legend(x="topright", lwd=1, col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create the last plot, Global_reactive_power x time
with(df, plot(x=Time, y=Global_reactive_power, type="l", xlab="datetime",
              ylab="Global_reactive_power"))

# Let's copy the plot to the required file...
dev.copy(png, file="./plot4.png")

# ...and close it.
dev.off()
