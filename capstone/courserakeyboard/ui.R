library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        # Application title
        titlePanel("Smart Coursera Keyboard"),
        sidebarLayout(
            sidebarPanel(
                p("Enter your text and hit *Predict*"),	
                textInput(inputId="text", label = ""),
                actionButton("predButton", "Predict"),
                HTML('<script type="text/javascript"> 
                        document.getElementById("text").focus();
                     </script>'
                )
            ),
            mainPanel(
                tabsetPanel(
                    tabPanel("Main Prediction",
                             verbatimTextOutput('bestPred')
                    ),
                    tabPanel("More results", 
                        conditionalPanel(condition = "input.text != ''",
                                         verbatimTextOutput("compTime"),
                                         verbatimTextOutput("suggestions")
                        )
                    )
                )
            )
        )
    )
)