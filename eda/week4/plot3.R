library(ggplot2)

NEI = readRDS("data/summarySCC_PM25.rds")
NEI = subset(NEI, fips=="24510")

fig = ggplot(
    NEI,
    aes(factor(year))
) +
    theme_bw() +
    geom_bar(aes(weight=Emissions)) + # weight -> sum
    guides(fill=FALSE) +
    facet_grid(.~type, scales="free", space="free") +
    labs(
        x="year",
        y="Total PM2.5 Emission (tons)",
        title="Emissions PM2.5 Baltimore City 1999-2008 by Source Type"
    )
print(fig)
dev.print(png, "plot3.png", width=480, height=480)
