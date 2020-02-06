#' Get Ethereum index data
#'
#' @return The data of all Ehtereum index
#' @export
getEth <- function(){
  key = getOption(ethereum.key)
  if(is.null(key)){
    stop("No api_key provided")
  }else{
    return(eth <- Quandl::Quandl("BITFINEX/ETHUSD", api_key=key))
  }
}

# "-GNJxjPntak8s-AxpM5o"