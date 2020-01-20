library(ggplot2)
library(scales)
library(Quandl)
library(dplyr)
library(readr)
library(forecast)
library(zoo)

library(rvest)
library(xml2)
library(rvest)
library(stringr)

#eth <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o")

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  url <- "https://ethereumprice.org/live/"
  webpage <- read_html(url)
  title_html <- html_nodes(webpage, "div#coin-price")
  perc_html <- html_nodes(webpage, "span#coin-changePercent")
  perc <- html_text(perc_html)
  print(perc)
  title <- html_text(title_html)
  price <- str_replace_all(title, "\n","")
  print(price)
  
  output$price <- renderText(price)
  
  observeEvent(input$reload, {
    output$price <- renderText(price)
  })
  
  output$distPlot <- renderPlot({
    
    startDF <- data.frame("Date"=eth$Date, "Price"=eth$Last)
    
    if(input$option==1){
      ggplot(eth, aes(x = eth$Date, y = eth$Last)) +
        labs(x = "Date", y = "Price") +
        geom_line() +
        scale_x_date(labels = date_format("%Y-%m-%d"))
    }
    
    else if(input$option==2){
      ggplot() + 
        geom_line(aes(x=Date, y=Price, colour="Ethereum price"), startDF) +  
        geom_line(aes(x=Date, y=MA, colour="Moving average"), smDF) 
    }
    else if(input$option==3){
      smDF <- data.frame("Date"=eth$Date,"MA"=rollmean(startDF$Price, k = 13, fill = NA))
      # Automated forecasting using an exponential model
      fit <- ets(startDF$Price)
      plot(fit)
    }
  })
}