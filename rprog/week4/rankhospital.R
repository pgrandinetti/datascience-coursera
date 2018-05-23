source("best.R")

rankhospital <- function(state, outcome, num = "best") {
    df = get_data()
    idx = map_outcome(outcome)
    splitted = split(df, df$State)
    aState = splitted[[state]]

    if (is.null(aState))
        stop("invalid state")

    if (num == "best")
        num = 1

    ordered = order(aState[, idx], aState[, 2], na.last=NA)
    sorted = aState[ordered, ]
    if (num == "worst")
        num = dim(sorted)[1]
    else {
        num = as.numeric(num)
        if (is.na(num) || num > dim(sorted)[1])
            return (NA)
    }
    sorted[num, ]$Hospital.Name
}
