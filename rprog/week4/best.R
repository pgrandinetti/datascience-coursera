get_data <- function() {
    df = read.csv(
        "data/outcome-of-care-measures.csv",
        colClasses="character"
    )
    df[, 11] = as.numeric(df[, 11]) # heart attack
    df[, 17] = as.numeric(df[, 17]) # heart failure
    df[, 23] = as.numeric(df[, 23]) # pneumonia
    df
}


map_outcome <- function(outcome) {
    if (outcome == "heart attack")
        return (11)
    if (outcome == "heart failure")
        return (17)
    if (outcome == "pneumonia")
        return (23)
    stop("invalid outcome")
}


best <- function(state, outcome) {
    df = get_data()
    idx = map_outcome(outcome)
    splitted = split(df, df$State)
    aState = splitted[[state]]
    if (is.null(aState))
        stop("invalid state")
    iMin = which(aState[[idx]] == min(aState[[idx]], na.rm=TRUE))
    result = aState[iMin, ]$Hospital.Name
    sort(result)[1]
}
