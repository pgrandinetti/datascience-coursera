complete <- function(directory, id=1:332){
    filePath = "%s/%03d.csv"
    nobs = vector(length=length(id))
    for (i in 1:length(id)){
        aFile = sprintf(filePath, directory, id[i])
        df = read.csv(aFile)
        nobs[i] = sum(complete.cases(df))
    }
    data.frame(id, nobs)
}
