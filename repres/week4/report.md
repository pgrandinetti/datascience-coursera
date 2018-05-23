NOAA Storm Database Analysis
============================

## Synopsis

This report shows our analysis of the NOAA Storm Databases. Data are provided through the Coursera platform, and we are interested in answering two main questions:

  1. Across the United States, which types of events are most harmful with respect to population health?

  2. Across the United States, which types of events have the greatest economic consequences?

The remainder of the report contain a walkthrough our reproducible research experiments.


## Data Processing

First of all, we used the following packages throughout the analysis


```r
library(R.utils)
library(data.table)
library(ggplot2)
library(gridExtra)
```

You will need to install them from CRAN in order to reproduce our results.

Data were provided in a compressed format via an URL in the Coursera page. We download the file with the following lines, that we placed in the following path


```r
stormDataBZPath = "./data/repdataStormData.csv.bz2"
if (! file.exists(stormDataBZPath)) {
    url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
    download.file(url, stormDataBZPath)
}
```

In order to load the data into memory we first decompress it and then use the fast `fread` function from the `data.table` package.


```r
stormDataCSV = "./data/stormData.csv"
if (! file.exists(stormDataCSV)) {
    bunzip2(stormDataBZPath, stormDataCSV, remove=F)
}
stormDT = fread(stormDataCSV, na.strings=c("NA", "N/A", "null", ""))
```

Before going further, we perform some data cleaning. In particular, the columns `PROPDMGEXP` and `CROPDMGEXP` contain the magnitude order that must be multiplied for `PROPDMG` and `CROPDMG`. These can be `B` (1e9), `M` (1e6), `K` (1e3), `H` (1e2), thus we create the following function.


```r
expTransf = function(x, y){
if (is.na(y)) return(0)
if (y=="B" || y=="b") return(x*1e9)
if (y=="M" || y=="m") return(x*1e6)
if (y=="K" || y=="k") return(x*1e3)
if (y=="H" || y=="h") return(x*1e2)
x
}
```

And then apply it (using `mapply`) to create two new variables in the data.


```r
stormDT[, propDamage:=mapply(expTransf, PROPDMG, PROPDMGEXP)]
stormDT[, cropDamage:=mapply(expTransf, CROPDMG, CROPDMGEXP)]
```

## Results

### First question

We first answer the question of the most harmful types of events.

Let's create a `data.table` that contains the sum of `FATALITIES` and `INJURIES` for each type of event. For the records, there are 985 types of events (TORNADO, HAIL, SNOW, etc.). We use the optimized functions available in `data.table`.


```r
toPlot = melt(stormDT, id="EVTYPE", measure=c("FATALITIES", "INJURIES"))
toPlot = toPlot[, .(damage=sum(value)), by=EVTYPE]
```

Now we can plot the results, by showing the top-25 types of events.


```r
p1 = ggplot(
    toPlot[order(-damage)][1:25,],
    aes(x=EVTYPE, y=damage)
) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("Event type") +
    ylab("Sum of fatalities and injuries") +
    ggtitle("25 Most harmful type of events in USA")

p2 = ggplot(
    toPlot[order(-damage)][2:25,],
    aes(x=EVTYPE, y=damage)
) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("Event type") +
    ylab("Sum of fatalities and injuries") +
    ggtitle("25 Most harmful type of events in USA (TORNADO excluded)")

grid.arrange(p1, p2, ncol=2)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

#### Caption/Comments

From the plot we can clearly see that the `TORNADO` type of event is the most harfmul. Since it strongly dominates the other, we have added a second plot of the same data, this time excluding the `TORNADO`, in order to analyze better the remaining elements. Thus, we can see that `EXCESSIVE HEAT`, `FLOOD` and `TSTM WIND` are the 2nd, 3rd and 4th most harmful event types.

### Second question
We now try to answer the question on which types of events have the greatest economic consequences.


```r
toPlot2 = melt(stormDT, id="EVTYPE", measure=c("propDamage", "cropDamage"))
toPlot2 = toPlot2[, .(damage=sum(value)), by=EVTYPE]
```


```r
ggplot(
    toPlot2[order(-damage)][1:25,],
    aes(x=EVTYPE, y=damage)
) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("Event type") +
    ylab("Economic consequences (USD)") +
    ggtitle("25 economically worst type of events in USA")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png)

#### Caption/Comments

From the plot we can clearly see that the `FLOOD`, `HURRICANE/TYPHOON` and `TORNADO` types of events are the most economically harfmul across USA.
