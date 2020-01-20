library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Ethereum price"),
  
  sidebarPanel(  
    fluidRow(
      h3("Actual Ehtereum price: "),
      h2(textOutput("price")),
      actionButton("reload", "Reload")
    )
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "option", h3("Select option"), 
                  choices = list("Price" = 1, "Moving Average" = 2,
                                 "Forecast" = 3), selected = 1)
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
     #plotOutput(outputId = "distPlot")
      
    )
  )
)