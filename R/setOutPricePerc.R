#' Set the input value in the correct output widget of the UI
#' @param price Actual price of Ehtereum index
#' @param perc Actual percentage of change in the Ethereum price index
#' @param output The output widget of the UI
#' @examples
#' setOutPricePerc("$164,37", "(1,23)", output)
setOutPricePerc <- function(price,perc, output){
  output$price <- shiny::renderText(price)
  output$percent <- shiny::renderText(perc)
  tm <- Sys.time()
  ts <- format(tm, format = "%Y-%m-%d %H:%M:%S", tz = "", usetz = FALSE)
  output$hour <- renderText(ts)
}