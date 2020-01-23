#library(shiny)

# Define UI for app
ui <- shiny::fluidPage(
  
  # App title
  shiny::titlePanel(shiny::h1("Ethereum Price Index")),
  
  shiny::sidebarPanel(  
    
    shiny::fluidRow(
      
      shiny::h3("Actual Ehtereum price: ",shiny::textOutput("price")),
   
      shiny::h4(shiny::textOutput("percent"))),
    
    shiny::fluidRow(shiny::actionButton("reload", "Reload"),
                    shiny::h5("Last update: ",shiny::textOutput("hour"))),
    
    shiny::fluidRow(shiny::selectInput(inputId = "option", shiny::h3("Select option"), 
                choices = list("Price" = 1, "Moving Average" = 2,
                               "Forecast" = 3), selected = 1)),
    shiny::sliderInput("slider1", shiny::h4("Number of observations (only for forecast)"),
                min = 10, max = 500, value = 200)
  ),
  
  
    # Main panel for displaying outputs
  shiny::mainPanel(
      
      # Output: plot
    shiny::plotOutput(outputId = "distPlot")
      
  )
)
