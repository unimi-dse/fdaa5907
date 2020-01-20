library(ggplot2)
library(scales)
library(Quandl)
library(dplyr)
library(readr)
library(forecast)
library(zoo)
library(shinyjs)

library(rvest)
library(xml2)
library(rvest)
library(stringr)

eth <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o")
url <- "https://ethereumprice.org/live/"
webpage <- read_html(url)
title_html <- html_nodes(webpage, "div#coin-price")
perc_html <- html_nodes(webpage, "span#coin-changePercent")
perc <- html_text(perc_html)
print(perc)
title <- html_text(title_html)
price <- str_replace_all(title, "\n","")
print(price)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  output$price <- renderText(price)
  output$percent <- renderText(perc)
  tm <- Sys.time()
  ts <- format(tm, format = "%Y-%m-%d %H:%M:%S", tz = "", usetz = FALSE)
  output$hour <- renderText(ts)
  
  observeEvent(input$reload, {
    eth <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o")
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
    output$percent <- renderText(perc)
    output$hour <- renderText(Sys.time())
    tm <- Sys.time()
    ts <- format(tm, format = "%Y-%m-%d %H:%M:%S", tz = "", usetz = FALSE)
    output$hour <- renderText(ts)
  })
  
  output$distPlot <- renderPlot({
    
    if(input$option==1){
      shinyjs::hide(id = "slider1")
      ggplot(eth, aes(x = eth$Date, y = eth$Last)) +
        labs(x = "Date", y = "Price") +
        geom_line() +
        scale_x_date(labels = date_format("%Y-%m-%d"))+ 
        theme(plot.title = element_text(face = "bold")) +
        labs(title = "Ethereum Price Chart", subtitle = "Daily data")
    }
    
    else if(input$option==2){
      shinyjs::hide(id = "slider1")
      smDF <- data.frame("Date"=eth$Date,"MA"=rollmean(eth$Last, k = 13, fill = NA))
      ggplot() + 
        labs(x = "Date", y = "Price") + 
        geom_line(aes(x=eth$Date, y=eth$Last, colour="Ethereum price"), eth) +  
        geom_line(aes(x=Date, y=MA, colour="Moving average"), smDF) + 
        theme(plot.title = element_text(face = "bold")) +
        labs(title = "Moving Average Chart", subtitle = "Daily data")
    }
    else if(input$option==3){
      shinyjs::show(id = "slider1")
      obs <- input$slider1
      n <- nrow(eth)
      div <- n/obs
      num <- n/div
      tot <- n-num
      ts1 <- ts1 <- ts(eth$Last[tot:n], start = 1, frequency = 1, class = "ts")
      plot(forecast(auto.arima(ts1)), sub = paste("Forecast with ",obs," observation"))
      # Automated forecasting using an exponential model
      #fit <- ets(startDF$Price)
      #plot(fit)
    }
  })
}