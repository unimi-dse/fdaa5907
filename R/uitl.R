#' @export
testFun <- function() {
  print("Yes, it works!")
}

#' @export
runFun <- function(){
  # run app -----------------------------------------------------------------
  shiny::runApp( shiny::shinyApp(ui, server), launch.browser = T )
}
