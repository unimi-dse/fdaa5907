
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
}

#' @export
runFun <- function(){
  library(shiny)
  # run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )
}