NEI = readRDS("data/summarySCC_PM25.rds")
NEI = subset(NEI, fips=="24510")
totals = tapply(NEI$Emissions, NEI$year, sum)

barplot(
    totals,
    names=c("1999", "2002", "2005", "2008"),
    xlab="year",
    ylab="Total PM2.5 emissions (tons)",
    main="PM2.5 emissions 1999-2008 in Baltimore"
)

dev.print(png, "plot2.png", width=480, height=480)
