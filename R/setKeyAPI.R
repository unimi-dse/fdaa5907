#' Set API key for getting the Ether data
#'
#' @return TRUE if the key is setted else FALSE
#' @example setKeyAPI("abc123")
#' @export
setKeyAPI <- function(key){
  getOption(ethereum.key=key)
  if(is.null(getOption(ethereum.key)))
    return(TRUE)
  else
    return(TRUE)
}