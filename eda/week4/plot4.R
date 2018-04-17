library(ggplot2)

NEI = readRDS("data/summarySCC_PM25.rds")
dfSCC = readRDS("data/Source_Classification_Code.rds")

combustion = grepl("comb", dfSCC$SCC.Level.One, ignore.case=T)
searched = grepl("coal", dfSCC$SCC.Level.Four, ignore.case=T) & combustion

NEI = subset(
        NEI,
        SCC %in% dfSCC$SCC[searched]
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
        title="Coal combustion PM2.5 emissions across USA 1999-2008"
    )
print(fig)
dev.print(png, "plot4.png", width=480, height=480)
