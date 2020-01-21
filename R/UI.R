library(shiny)
library(shinyjs)

# Define UI for app
ui <- fluidPage(
  
  # App title
  titlePanel(h1("Ethereum Price Index")),
  
  sidebarPanel(  
    
    fluidRow(
      
      h3("Actual Ehtereum price: ",textOutput("price")),
   
      h4(textOutput("percent"))),
    
    fluidRow(actionButton("reload", "Reload"),
             h5("Last update: ",textOutput("hour"))),
    
    fluidRow(selectInput(inputId = "option", h3("Select option"), 
                choices = list("Price" = 1, "Moving Average" = 2,
                               "Forecast" = 3), selected = 1)),
    hidden(sliderInput("slider1", h4("Number of observations (only for forecast)"),
                min = 10, max = 500, value = 200)
    )
  ),
  
  
    # Main panel for displaying outputs
    mainPanel(
      
      # Output: plot
     plotOutput(outputId = "distPlot")
      
  )
)
