#' Get Ethereum index data
#'
#' @return The data of all Ehtereum index
#' @export
getEth <- function(){
  key = Sys.getenv("apiKey")
  if(is.null(key)){
    stop("No api_key provided")
  }else{
    return(eth <- Quandl::Quandl("BITFINEX/ETHUSD", api_key=key))
  }
}

#' Set API key for getting the Ether data
#'
#' @return TRUE if the key is setted else FALSE
#' @example setKeyAPI("abc123")
#' @export
setKeyAPI <- function(apikey){
  Sys.setenv("apiKey"=apikey)
  key = Sys.getenv("apiKey")
  if(is.null(key))
   return(FALSE)
  else
   return(TRUE)
}
