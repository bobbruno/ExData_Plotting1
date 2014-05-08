######################################################################################
#
# Plot1.R: Generates the "Global Active Power" Histogram in red
#
# By Roberto Bruno Martins (bobbruno@github.com)
#
# For the John Hopkins Data Science Track "Exploratory Data Analysis" course project 1
#
######################################################################################

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

# Create the histogram. The "cex.*" parameters reduce font size for main, labels and axles
# I added them because my original plot seemed to have larger text than the examples.
hist(df$Global_active_power, xlab="Global Active Power (kilowatts)", 
     col = "red", main="Global Active Power", cex.main=0.9, cex.lab = 0.8, cex.axis = 0.8)

# Let's copy the plot to the required file...
dev.copy(png, file="./plot1.png")

# ...and close it.
dev.off()
