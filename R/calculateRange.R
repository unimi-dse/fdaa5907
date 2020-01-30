
#' Calculate the range, given the number of observation, for the forecast
#' #'
#' @param obs Selected number of observation
#' @param n Total number of observation
#' @examples
#' calculateRange(300,1367)
#' @export
calculateRange <- function(obs,n){
  div <- n/obs
  num <- n/div
  tot <- n-num
  return(tot)
}