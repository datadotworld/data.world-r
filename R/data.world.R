#' data.world client constructor
#' @param propsfile a properties file containing configuration for your data.world client (defaults to ~/.data.world)
#' @param token your data.world API token (optional, if not present, will be read from properties file)
#'
#' @return a data.world client
#' @seealso \code{\link{query}}
#' @examples
#' connection <- data.world()
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' connection <- data.world(propsfile = "~/.data.world")
#' @export
data.world <- function(token = NULL,
                       propsfile = sprintf("%s/.data.world", path.expand('~'))) {
  is.nothing <- function(x) is.null(x) || is.na(x) || is.nan(x)

  props <- if (file.exists(propsfile))
    read.table(propsfile, header = FALSE, sep = "=", row.names = 1,
               strip.white = TRUE,na.strings = "NA", stringsAsFactors = FALSE)
  else
    data.frame()
  if (is.nothing(token) && is.nothing(props["token", 1]))
    stop("you must either provide an API token to this constructor, or create a
          .data.world file in your home directory with your API token")
  me <- list(
    token = if(is.nothing(props["token", 1])) token else props["token", 1]
    )
  class(me) <- "data.world"
  return(me)
}
