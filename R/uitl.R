#' @export
testFun <- function() {
  print("Yes, it works!")
}

#' @export
runFun <- function(){
  
  dependencies <- c("shiny", "shinyjs", "ggplot2", "scales", "Quandl", "dplyr",
                    "readr", "forecast", "zoo", "rvest","xml2","stringr")
  
  for (x in dependencies) {
    if(x %in% rownames(installed.packages()) == T) {
      library(x, character.only = T)
    } else {
      install.packages(x)
      library(x, character.only = T)
    }
  }
  
  print("Packages installed")
  
 
  # run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )
}