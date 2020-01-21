
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
      Sys.sleep(5)
    }
  }
  
  # run app -------------------------------------
  runApp( shinyApp(UI, server), launch.browser = T )

}