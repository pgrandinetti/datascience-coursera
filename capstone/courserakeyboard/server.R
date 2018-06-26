library(shiny)
library(tm)
library(stringr)
library(DBI)
library(RSQLite)

# Define server logic required to draw a histogram
shinyServer(
    function(input, output, session) {
        observe({
            startTime = Sys.time()
            res = predictWord(input$text)
            output$suggestions = renderText({paste0(res, collapse=" | ")})
            output$compTime = renderText({sprintf("Total computation time is %3.6f seconds", Sys.time() - startTime)})
        })
    }
)

predictWord = function(sentence){
    # defalult values
    x1 = 0.005
    x2 = 0.6
    x3 = 0.9
    aLine = cleanLine(sentence)
    splitted = str_split(aLine, pattern=" ")[[1]]
    tot = length(splitted)
    if (tot > 2)
        line3 = str_c(splitted[(tot-2):tot], collapse=" ")
    else
        line3 = "NULL"
    if (tot > 1)
        line2 = str_c(splitted[(tot-1):tot], collapse=" ")
    else
        line2 = "NULL"
    if (tot > 0)
        line1 = splitted[tot]
    else
        line1 = "NULL"
    
    stops = stopwords(kind="en")
    if (line1 %in% stops)
        x1 = 0.0001
    
    #print(list(c(line1, x1), c(line2, x2), c(line3, x3)))
    
    dbPath = "./ngramDB_v1.db"
    predictWord_internal(line1, line2, line3, dbPath, x1=x1, x2=x2, x3=x3)
}

predictWord_internal = function(line1, line2, line3, dbPath, x1, x2, x3){
    dbConn = dbConnect(SQLite(), dbname=dbPath)
    query = "
    select prediction, sum(xx) as weight
    from (
        select
            value,
            prediction,
            count,
            count * CASE  WHEN value=$line3 THEN $x3 WHEN value=$line2 THEN $x2 ELSE $x1 END xx
        from NGRAM 
        where value=$line3 or value=$line2 or value=$line1
    )
    group by prediction
    order by weight desc
    LIMIT 4;"
    params = list(line1=line1, line2=line2, line3=line3, x1=x1, x2=x2, x3=x3)
    res = dbSendQuery(
        dbConn,
        query,
        params=params
    )
    res = dbFetch(res, n=-1)
    #res
    res$prediction
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