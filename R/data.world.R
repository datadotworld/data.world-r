'data.world-r
Copyright 2017 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.(http://www.data.world/).'

#' data.world client constructor
#' @param propsfile a properties file containing configuration for your data.world client (defaults to ~/.data.world)
#' @param token your data.world API token (optional, if not present, will be read from properties file)
#' @param baseDWApiUrl data.world public api
#' @param baseQueryApiUrl data.world query api
#' @param baseDownloadApiUrl data.world download api
#' @return a data.world client
#' @seealso \code{\link{query}}
#' @examples
#' connection1 <- data.world(token = "YOUR_API_TOKEN_HERE")
#' @export
data.world <- function(token = NULL,
                       propsfile = sprintf("%s/.data.world", path.expand('~')),
                       baseDWApiUrl = "https://api.data.world/v0/",
                       baseQueryApiUrl = "https://query.data.world/",
                       baseDownloadApiUrl = "https://download.data.world") {
  is.nothing <- function(x) is.null(x) || is.na(x) || is.nan(x)

  props <- if (file.exists(propsfile))
    utils::read.table(propsfile, header = FALSE, sep = "=", row.names = 1,
               strip.white = TRUE,na.strings = "NA", stringsAsFactors = FALSE)
  else
    data.frame()
  if (is.nothing(token) && is.nothing(props["token", 1]))
    stop("you must either provide an API token to this constructor, or create a
          .data.world file in your home directory with your API token")
  t = if (!is.nothing(token)) token else (if(is.nothing(props["token", 1])) token else props["token", 1])
  me <- list(
    token = t,
    baseDWApiUrl = baseDWApiUrl,
    baseQueryApiUrl = baseQueryApiUrl,
    baseDownloadApiUrl = baseDownloadApiUrl
    )
  class(me) <- "data.world"
  return(me)
}
