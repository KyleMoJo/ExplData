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

png("plot3.png", 480, 480)
par(cex.axis = 0.8)
plot(elec$Sub_metering_1, type = "l", xaxt = "n", xlab = "",
           ylab = "Energy sub metering")
lines(elec$Sub_metering_2, col = "red")
lines(elec$Sub_metering_3, col = "blue")

axis(1, at = c(1, 1+24*60, 1+48*60), xaxp = c(0, 2885, 3), 
     labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c(names(elec)[6:8]), lty = 1, cex = 0.8,
       col = c("black", "red", "blue"))
dev.off()
