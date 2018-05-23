library(ggplot2)

NEI = readRDS("data/summarySCC_PM25.rds")
dfSCC = readRDS("data/Source_Classification_Code.rds")

searched = grepl("vehicle", dfSCC$SCC.Level.Two, ignore.case=T)

baltNEI = subset(
        NEI,
        (SCC %in% dfSCC$SCC[searched] & fips=="24510")
)
LANEI = subset(
        NEI,
        (SCC %in% dfSCC$SCC[searched] & fips=="06037")
)
baltimoreTot = tapply(baltNEI$Emissions, baltNEI$year, sum)
laTot = tapply(LANEI$Emissions, LANEI$year, sum)

# Will normalize the data to show which of the two cities
# has seen greater changes over time
toPlot = rbind(
    data.frame(
        year=c("1999", "2002", "2005", "2008"),
        emissions=baltimoreTot/max(baltimoreTot),
        city="Baltimore"
    ),
    data.frame(
        year=c("1999", "2002", "2005", "2008"),
        emissions=laTot/max(laTot),
        city="Los Angeles"
    )
)
fig = ggplot(
    toPlot,
    aes(factor(year), emissions)
) +
    theme_bw() +
    geom_bar(stat='identity') +
    facet_grid(.~city,scales = "free",space="free") + 
    labs(
        x="year",
        y="Total PM2.5 Emission (Normalized)",
        title="Comparion emissions Baltimore vs Los Angeles (normalized values) 1999-2008"
    )
print(fig)
dev.print(png, "plot6.png", width=520, height=480)
