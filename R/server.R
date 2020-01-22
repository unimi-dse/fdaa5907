library(ggplot2)
library(scales)
library(Quandl)
library(dplyr)
library(readr)
library(forecast)
library(zoo)
library(devtools)
library(xml2)
library(rvest)
library(stringr)

#' Get Ethereum index data
#'
#' @return The data of all Ehtereum index
getEth <- function(){
  return(eth <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o"))
}

setClass(Class="pricePerc",
         representation(
           price="character",
           perc="character"
         )
)

#' Get actual Price and Percentage of change of Ethereum Index
#'
#' @return A class formed by Price and Percentage of change
getPricePerc <- function(){
  url <- "https://ethereumprice.org/live/"
  webpage <- read_html(url)
  title_html <- html_nodes(webpage, "div#coin-price")
  perc_html <- html_nodes(webpage, "span#coin-changePercent")
  perc <- html_text(perc_html)
  title <- html_text(title_html)
  price <- str_replace_all(title, "\n","")
  print("Data retrieved")
  return(new("pricePerc",price=price,perc=perc))
}

#' Set the input value in the correct output widget of the UI
#' @param price Actual price of Ehtereum index
#' @param perc Actual percentage of change in the Ethereum price index
#' @param output The output widget of the UI
#' @examples
#' setOutPricePerc("$164,37", "(1,23)", output)
setOutPricePerc <- function(price,perc, output){
  output$price <- renderText(price)
  output$percent <- renderText(perc)
  tm <- Sys.time()
  ts <- format(tm, format = "%Y-%m-%d %H:%M:%S", tz = "", usetz = FALSE)
  output$hour <- renderText(ts)
}

#' Calculate the range, given the number of observation, for the forecast
#' #'
#' @param obs Selected number of observation
#' @param n Total number of observation
#' @examples
#' calculateRange(300,1367)
calculateRange <- function(obs,n){
  div <- n/obs
  num <- n/div
  tot <- n-num
  return(tot)
}

#' Define the server logic
#' #'
server <- function(input, output) {
  
  p <- getPricePerc()
  eth <- getEth()
  setOutPricePerc(p@price,p@perc, output)
  
  observeEvent(input$reload, {
    
    eht <- getEth()
    p <- getPricePerc()
    setOutPricePerc(p@price,p@perc,output)
    
  })
  
  output$distPlot <- renderPlot({
    
    if(input$option==1){
      #shinyjs::hide(id = "slider1")
      ggplot(eth, aes(x = eth$Date, y = eth$Last)) +
        labs(x = "Date", y = "Price") +
        geom_line() +
        scale_x_date(labels = date_format("%Y-%m-%d"))+ 
        theme(plot.title = element_text(face = "bold")) +
        labs(title = "Ethereum Price Chart", subtitle = "Daily data")
    }
    
    else if(input$option==2){
      #shinyjs::hide(id = "slider1")
      smDF <- data.frame("Date"=eth$Date,"MA"=rollmean(eth$Last, k = 13, fill = NA))
      ggplot() + 
        labs(x = "Date", y = "Price") + 
        geom_line(aes(x=eth$Date, y=eth$Last, colour="Ethereum price"), eth) +  
        geom_line(aes(x=Date, y=MA, colour="Moving average"), smDF) + 
        theme(plot.title = element_text(face = "bold")) +
        labs(title = "Moving Average Chart", subtitle = "Daily data")
    }
    else if(input$option==3){
      #shinyjs::show(id = "slider1")
      obs <- input$slider1
      end <- nrow(eth)
      start <- calculateRange(obs,end)
      ts1 <- ts1 <- ts(eth$Last[start:end], start = 1, frequency = 1, class = "ts")
      plot(forecast(auto.arima(ts1)), sub = paste("Forecast with ",obs," observation"))
    }
  })
}
