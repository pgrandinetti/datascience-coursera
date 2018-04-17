NEI = readRDS("data/summarySCC_PM25.rds")
totals = tapply(NEI$Emissions, NEI$year, sum)

barplot(
    totals,
    names=c("1999", "2002", "2005", "2008"),
    xlab="year",
    ylab="Total PM2.5 emissions (tons)",
    main="PM2.5 emissions 1999-2008"
)
dev.print(png, "plot1.png", width=480, height=480)
