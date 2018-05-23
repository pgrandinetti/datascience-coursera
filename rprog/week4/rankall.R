source("best.R")

# NOTE: Assignment says we can't call rankhospital.R

rankall <- function(outcome, num = "best") {
    df = get_data()
    idx = map_outcome(outcome)
    ordered = order(df[, idx], df[, 2], na.last=NA)
    sorted = df[ordered, ]
    splitted = split(sorted$Hospital.Name, sorted$State)
    state = names(splitted)
    hospital = vector(length=length(state))
    for (i in 1:length(state)) {
        aState = splitted[[state[i]]]
        if (num == "best")
            hospital[i] = aState[1]
        else if (num == "worst")
            hospital[i] = tail(aState, n=1)
        else {
            num = as.numeric(num)
            if (is.na(num) || num > length(aState))
                hospital[i] = NA
            else
                hospital[i] = aState[num]
        }
    }
    data.frame(hospital, state)
}
