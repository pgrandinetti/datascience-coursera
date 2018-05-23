source("loadData.R")

## Set the local path to the data
dataPath = "~/Downloads/data.txt"

dt = loadData(dataPath)

time = 1:dim(dt)[1]
ticks = with(
        dt, 
        which(Time=="00:00:00")
)
ticks = c(ticks, dim(dt)[1])

par(mfrow=c(2,2))

## First (1x1) Plot
plot(
    time,
    dt$Global_active_power,
    type="l",
    ylab="Global Active Power",
    xaxt="n", xlab=""
)
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

## Second (1x2) plot
plot(
    time,
    dt$Voltage,
    type="l",
    ylab="Voltage",
    xaxt="n", xlab=""
)
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))
title(xlab="datetime")

## Third (2x1) plot
colors = c("black", "red", "blue")
plot(
    time,
    dt$Sub_metering_1,
    type="n",
    xaxt="n",
    xlab="",
    ylab="Energy sub metering"
)
lines(time, dt$Sub_metering_1, col=colors[1])
lines(time, dt$Sub_metering_2, col=colors[2])
lines(time, dt$Sub_metering_3, col=colors[3])
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))
legend(
    "topright",
    legend=c(
        "Sub_metering_1",
        "Sub_metering_2",
        "Sub_metering_3"),
    lty=c(1,1,1),
    bty="n",
    col=colors
)

## Fourth (2x2) plot
plot(
    time,
    dt$Global_active_power,
    type="l",
    ylab="Global_active_power",
    xaxt="n", xlab=""
)
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))
title(xlab="datetime")

## Save to file
dev.print(png, "plot4.png", width=480, height=480)
