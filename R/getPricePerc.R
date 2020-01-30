#' Get actual Price and Percentage of change of Ethereum Index
#'
#' @return A class formed by Price and Percentage of change
#' @export
getPricePerc <- function(){
  url <- "https://ethereumprice.org/live/"
  webpage <- xml2::read_html(url)
  title_html <- rvest::html_nodes(webpage, "div#coin-price")
  perc_html <- rvest::html_nodes(webpage, "span#coin-changePercent")
  perc <- rvest::html_text(perc_html)
  title <- rvest::html_text(title_html)
  price <- stringr::str_replace_all(title, "\n","")
  print("Data retrieved")
  return(new("pricePerc",price=price,perc=perc))
}