source("complete.R")

corr <- function(directory, threshold=0){
    nobs = complete(directory)
    filePath = "%s/%03d.csv"
    ok = nobs[nobs$nobs>threshold,]
    result = vector("numeric", length=dim(ok)[1])
    if (dim(ok)[1] == 0){
        return(result)
    }
    for (i in 1:nrow(ok)){
        aFile = sprintf(filePath, directory, ok[i,]$id)
        df = read.csv(aFile)
        result[i] = cor(df$nitrate, df$sulfate, use="complete.obs")
    }
    result
}
