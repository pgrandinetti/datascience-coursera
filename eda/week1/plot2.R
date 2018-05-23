source("loadData.R")

## Set the local path to the data
dataPath = "~/Downloads/data.txt"

dt = loadData(dataPath)

plot(
    1:dim(dt)[1],
    dt$Global_active_power,
    type="l",
    ylab="Global Active Power (kilowatts)",
    xaxt="n", xlab=""
)

ticks = with(
        dt, 
        which(Time=="00:00:00")
)
ticks = c(ticks, dim(dt)[1])
axis(1, at=ticks, labels=c("Thu", "Fri", "Sat"))

dev.print(png, "plot2.png", width=480, height=480)
