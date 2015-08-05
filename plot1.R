fullelec <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep = ";", comment.char = "", na.strings = "?", 
                       colClasses = c("character", "character", rep("numeric",7)))
Day1 <- fullelec[,1] == "1/2/2007"
Day2 <- fullelec[,1] == "2/2/2007"
Want <- as.logical(Day1 + Day2)
elec <- fullelec[Want,]
timelt <- lapply(paste(elec[,1],elec[,2]), strptime, format = "%d/%m/%Y %H:%M:%S")
timect <- sapply(timelt, as.POSIXct)
class(timect) <- "POSIXct"
elec <- cbind(timect,elec[,3:9])
names(elec)[1] = "Date&Time"
rm(list = c("fullelec","Day1","Day2", "Want", "timelt", "timect"))

png("plot1.png", 480, 480)
par(cex.axis = 0.6)
hist(elec$Global_active_power, col="red", breaks = 12, ylim = c(0, 1200),
     main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)")
dev.off()