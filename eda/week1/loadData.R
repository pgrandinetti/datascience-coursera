library(data.table)

loadData = function(fPath) {
    # Read the entire dataset - memory is OK
    # and fread+subset is faster than read.csv.sql
    dt = fread(
        fPath,
        sep=";",
        na.strings=c("NA", "?")
    )
    # Specify date format
    fmt = "%d/%m/%Y"
    # select only needed rows
    dt.sub = subset(
        dt,
        (as.Date(Date, fmt)=="2007-02-01" | as.Date(Date, fmt)=="2007-02-02")
    )
}
