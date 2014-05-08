df = read.csv2("household_power_consumption.txt", dec=".", nrows=2075260,
               na.strings = "?", header=TRUE, stringsAsFactors=FALSE)

df$Time = strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date = as.Date(df$Date, "%d/%m/%Y")

df = subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

hist(df$Global_active_power, xlab="Global Active Power (kilowatts)", 
     col = "red", main="Global Active Power", cex.main=0.9, cex.lab = 0.8, cex.axis = 0.8)

dev.copy(png, file="plot1.png")
dev.off()
