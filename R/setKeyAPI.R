#' Set API key for getting the Ether data
#'
#' @return TRUE if the key is setted else FALSE
#' @example setKeyAPI("abc123")
#' @export
setKeyAPI <- function(apikey){
  ethereum.key = apikey
  if(is.null(ethereum.key))
    return(TRUE)
  else
    return(TRUE)
}