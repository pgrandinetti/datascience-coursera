library(ggplot2)

NEI = readRDS("data/summarySCC_PM25.rds")
dfSCC = readRDS("data/Source_Classification_Code.rds")

searched = grepl("vehicle", dfSCC$SCC.Level.Two, ignore.case=T)

NEI = subset(
        NEI,
        (SCC %in% dfSCC$SCC[searched] & fips=="24510")
)

fig = ggplot(
    NEI,
    aes(factor(year))
) +
    theme_bw() +
    geom_bar(aes(weight=Emissions)) + # weight -> sum
    labs(
        x="year",
        y="Total PM2.5 Emission (tons)",
        title="Coal combustion PM2.5 emissions in Baltimore 1999-2008"
    )
print(fig)
dev.print(png, "plot5.png", width=480, height=480)
