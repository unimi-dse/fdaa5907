
#' Create a Graphic User Interface
#'
#' @export
GUI <- function(){
  
  shiny::runApp(system.file("shiny/GUI", package = "ethereum"))
  
}
