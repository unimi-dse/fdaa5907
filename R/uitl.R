
#' @export
testFun <- function() {
  print("Yes, it works!")
}

#' @export
installPack <- function()
{
  packages  =c("shiny", "shinyjs", "ggplot2", "scales", "Quandl", "dplyr", "readr", "forecast", "zoo", "rvest", "xml2", "stringr")
  if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())),repos = "http://cran.us.r-project.org")
  }else
    print("everything up to date")
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
  
}

#' @export
runFun <- function(){
 
  # run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )
}