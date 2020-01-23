#' @export
testFun <- function() {
  print("Yes, it works!")
}

# Check, Install and Load the required library
#installPack <- function()
##{
##  packages  =c("shiny", "ggplot2", "scales", "Quandl", "dplyr", "readr", "forecast", "zoo", "rvest", "xml2", "stringr")
 # if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
#    install.packages(setdiff(packages, rownames(installed.packages())),repos = "http://cran.us.r-project.org")
#  }else{
##    print("everything up to date")
##    library(ggplot2)
#  library(scales)
#  library(Quandl)
#  library(dplyr)
 # library(readr)
 # library(forecast)
  #library(zoo)
  #library(devtools)
  #library(xml2)
  #library(rvest)
  #library(stringr)
  #print("Library correctly loaded")
  #}
#}

#' @export
runFun <- function(){
  # run app -----------------------------------------------------------------
  shiny::runApp( shiny::shinyApp(ui, server), launch.browser = T )
}
