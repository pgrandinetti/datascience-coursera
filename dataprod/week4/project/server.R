# the server side

# initialize the array that store all comments
values <- c(0,0,0,0)

shinyServer(
  function(input, output, session) {
    
    #react to the actionButton
    datainput <- eventReactive(input$action, {
      #take the current value
      value <- as.numeric(input$id2)
      #update all values with correct scope
      values[value] <<- values[value] + 1
      
      #refresh the checkGroup
      observe({
        updateCheckboxGroupInput(session, "id2",
                                 choices = c("Yes" = 1,
                                             "No" = 2,
                                             "Maybe" = 3,
                                             "What are you waiting?" = 4))
      })
      #return the values
      values
    })
    
    # simply bar the historical data
    # call the datainput() inside
    output$bar<- renderPlot({
      barplot(datainput(),names.arg = c('Yes','No','Maybe','WAYW?'),
              ylim = c(0,30)
      )
    })
    
  }
)