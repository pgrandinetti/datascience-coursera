pollutantmean <- function(directory, pollutant, id=1:332){
    filePath = "%s/%03d.csv"
    allSum = 0
    allLength = 0
    for (i in id){
        aFile = sprintf(filePath, directory, i)
        df = read.csv(aFile)
        allSum = allSum + sum(df[[pollutant]], na.rm=TRUE)
        allLength = allLength + sum(TRUE - is.na(df[[pollutant]]))
    }
    allSum/allLength
}
