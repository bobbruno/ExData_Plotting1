######################################################################################
#
# Plot3.R: Generates the line plot for 3 submeters
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

# Create the line graph. The "cex.*" parameters reduce font size for main, labels and axles
# I added them because my original plot seemed to have larger text than the examples.
plot(x= df$Time, y=df$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering", cex.lab = 0.8, cex.axis = 0.8, 
     col="black")
# Adds the second submeter
lines(x=df$Time, y=df$Sub_metering_2, type="l",col="red")
# Adds the third submeter
lines(x=df$Time, y=df$Sub_metering_3, type="l",col="blue")
# Adds the legend
legend(x="topright", lwd=1, col=c("black", "red", "blue"), cex=0.8,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Let's copy the plot to the required file...
dev.copy(png, file="./plot3.png")

# ...and close it.
dev.off()
