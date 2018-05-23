source("loadData.R")

## Set the local path to the data
dataPath = "~/Downloads/data.txt"

dt = loadData(dataPath)

hist(
    dt$Global_active_power,
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)"
)

dev.print(png, "plot1.png", width=480, height=480)
