makeDataset = function(folderPath, dev=8e3, val=1e3, test=1e3) {
    conn = file(file.path(folderPath, "en_US.blogs.txt"), "rt")
    devLinesBlog = readLines(conn, n=dev)
    valLinesBlog = readLines(conn, n=val)
    testLinesBlog = readLines(conn, n=test)
    close(conn)
    
    conn = file(file.path(folderPath, "en_US.news.txt"), "rt")
    devLinesNews = readLines(conn, n=dev)
    valLinesNews = readLines(conn, n=val)
    testLinesNews = readLines(conn, n=test)
    close(conn)
    
    conn = file(file.path(folderPath, "en_US.twitter.txt"), "rt")
    devLinesTweet = readLines(conn, n=dev)
    valLinesTweet = readLines(conn, n=val)
    testLinesTweet = readLines(conn, n=test)
    close(conn)
    
    list(train=list(devLinesBlog, devLinesNews, devLinesTweet),
         val=list(valLinesBlog, valLinesNews, valLinesTweet),
         test=list(testLinesBlog, testLinesNews, testLinesTweet))
}