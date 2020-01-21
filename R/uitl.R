#' @export
testFun <- function() {
  print("Yes, it works!")
}

#' @export
runFun <- function(){
 
  # run app -----------------------------------------------------------------
  runApp( shinyApp(ui, server), launch.browser = T )
}