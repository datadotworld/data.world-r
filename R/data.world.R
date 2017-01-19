#' data.world client constructor
#' @param token your data.world API token
#'
#' @return a data.world client
#' @export
data.world <- function(token) {
  me <- list( token = token )
  class(me) <- "data.world"
  return(me)
}
