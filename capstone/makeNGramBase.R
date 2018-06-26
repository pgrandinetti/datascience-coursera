library(RWeka)
library(DBI)
library(RSQLite)
library(stringr)
library(tm)

makeNGramData = function(folderPath, dbPath="./ngramDB.db", dev=5e3){
    
    conn = file(file.path(folderPath, "en_US.blogs.txt"), "rt")
    devLinesBlog = readLines(conn, n=dev)
    close(conn)
    conn = file(file.path(folderPath, "en_US.news.txt"), "rt")
    devLinesNews = readLines(conn, n=dev)
    close(conn)
    conn = file(file.path(folderPath, "en_US.twitter.txt"), "rt")
    devLinesTweet = readLines(conn, n=dev)
    close(conn)
    
    dbPath = "./ngramDB.db"
    makeDB(dbPath)
    
    allLines = c(devLinesBlog, devLinesNews, devLinesTweet)
    for (line in allLines){
        aLine = cleanLine(line)
        #print(aLine)
        ngrams = NGramTokenizer(aLine, Weka_control(min = 2, max = 4))
        for (ngram in ngrams){
            storeNGram(dbPath, ngram)
        }
    }
}

cleanLine = function(line){
    aLine = str_trim(line)
    aLine = removePunctuation(aLine, preserve_intra_word_dashes=TRUE)
    aLine = tolower(aLine)
    aLine = gsub("[“”’\\/\"^£$%&|#]", '', aLine)
    aLine = iconv(aLine, "utf-8", "ASCII", sub="")
    aLine = stripWhitespace(aLine)
    return(aLine)
}

makeDB = function(dbPath){
    if (! file.exists(dbPath)){
        file.create(dbPath)
    }
    query = "CREATE TABLE IF NOT EXISTS NGRAM (
            value text NOT NULL,
            prediction text NOT NULL,
            count integer,
            UNIQUE (value, prediction))"
    dbConn = dbConnect(SQLite(), dbname=dbPath)
    dbExecute(dbConn, query)
    dbDisconnect(dbConn)
}
    
storeNGram = function(dbPath, ngram){
    dbConn = dbConnect(SQLite(), dbname=dbPath)
    value = word(ngram, start=1, end=-2)
    pred = word(ngram, -1)
    query2 = "INSERT OR REPLACE INTO NGRAM (value, prediction, count)
        VALUES (
        $val, $pred,
        COALESCE((SELECT count+1 from NGRAM WHERE value=$val AND prediction=$pred), 1)
        );"
    dbExecute(dbConn, query2, params=list(val=value, pred=pred))
    dbDisconnect(dbConn)
}