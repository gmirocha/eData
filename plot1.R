## Data Load
Dt <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date 
Dt$Date <- as.Date(Dt$Date, "%d/%m/%Y")
  
## Filter data Feb. 1, 2007 - Feb. 2, 2007
Dt <- subset(Dt,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
Dt <- Dt[complete.cases(Dt),]

## Combine Date and Time column
dateTime <- paste(Dt$Date, Dt$Time)
  
## Vector name
dateTime <- setNames(dateTime, "DateTime")
  
## Drop Date/Time columns and add DTTime col
Dt <- Dt[ ,!(names(Dt) %in% c("Date","Time"))]
Dt <- cbind(dateTime, Dt)
  
## Format dateTime Column
Dt$dateTime <- as.POSIXct(dateTime)

## Ploting
hist(Dt$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()