source("loadData.R")

## Set the local path to the data
dataPath = "~/Downloads/data.txt"

dt = loadData(dataPath)

time = 1:dim(dt)[1]
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
ticks = with(
        dt, 
        which(Time=="00:00:00")
)
ticks = c(ticks, dim(dt)[1])
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))
legend(
    "topright",
    legend=c(
        "Sub_metering_1",
        "Sub_metering_2",
        "Sub_metering_3"),
    lty=c(1,1,1),
    col=colors
)

dev.print(png, "plot3.png", width=480, height=480)
