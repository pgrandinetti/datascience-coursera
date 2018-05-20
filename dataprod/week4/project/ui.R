library(shiny)

# There will be a left panel with the instructions
# and a right panel with two tabs, one for the results and one for the documentation

shinyUI(fluidPage(
  titlePanel("Hello, there!"),
  sidebarPanel(
    h1('My github account is quite empty!'),
    h2('But this is why I discover git since a few time!'),
    h3('Do you think I should upload all of my existing projects on github?'),
    checkboxGroupInput("id2", "You may select more than one...",
                       c("Yes" = 1,
                         "No" = 2,
                         "Maybe" = 3,
                         "What are you waiting?" = 4)),
    actionButton('action','Share!'),
    width = 8
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Results",
               h3("Here is your opinions!"),
               plotOutput('bar')
      ),
      tabPanel("Documentation",
               p("The usage of the app is extremely intuive."),
               p("A sidebar panel, on the left, tells us the story in short, 
                  and invite us to give some suggestions to Pete about his dilemma."),
               p("In the same panel there are also the choices. 
                  The reader is kindly invited to give his own advice!"),
               p("On the right, a barplot (in the sense of R function), show the historical results. 
                  This means that every user can see what the others have voted before than him."),
               p("In a second tab is shown a short version of the documentation, 
                  and the link to the pdf documentation."),
               a("clik here to see the documentation!", 
                 href="https://pgrandinetti.github.io/datascience-coursera/dataprod/week4/pitch/pitchRpres.html")
      )
    ),
    width = 4
  )
))