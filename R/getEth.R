#' Get Ethereum index data
#'
#' @return The data of all Ehtereum index
getEth <- function(){
  return(eth <- Quandl::Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o"))
}