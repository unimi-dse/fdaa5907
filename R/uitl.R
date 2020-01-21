library(ggplot2)
library(scales)
library(Quandl)
library(dplyr)
library(readr)
library(forecast)
library(zoo)
library(shinyjs)
library(devtools)
library(xml2)
library(rvest)
library(stringr)

library(shiny)
library(shinyjs)

#' @export
testFun <- function() {
  print("Yes, it works!")
}

#' @export
runFun <- function(){
 
  # run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )
}