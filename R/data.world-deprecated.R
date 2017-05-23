"data.world-r
Copyright 2017 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.
https://data.world"

#' Deprecated function(s) in the data.world package
#'
#' These functions have been marked for removal from the data.world package.
#' @rdname data.world-deprecated
#' @name data.world-deprecated
#' @aliases query.data.world
#' @docType package
#' @section Details:
#' \tabular{ll}{
#'    \code{data.world} \tab is replaced by \code{\link{set_config}}\cr
#'    \code{query.data.world} \tab is replaced by \code{\link{query}}\cr
#' }
NULL

#' @export
data.world <- function(token = NULL,
  propsfile = sprintf("%s/.data.world", path.expand("~")),
  baseDWApiUrl = "https://api.data.world/v0/",
  baseQueryApiUrl = "https://query.data.world/",
  baseDownloadApiUrl = "https://download.data.world") {
  .Deprecated("data.world::configure", "data.world")

  is.nothing <- function(x)
    is.null(x) || is.na(x) || is.nan(x)

  if (file.exists(propsfile)) {
    props <-
      utils::read.table(
        propsfile,
        header = FALSE,
        sep = "=",
        row.names = 1,
        strip.white = TRUE,
        na.strings = "NA",
        stringsAsFactors = FALSE
      )
  } else {
    props <- data.frame()
  }

  if (is.nothing(token) && is.nothing(props["token", 1])) {
    stop(
      "you must either provide an API token to this constructor, or create a
      .data.world file in your home directory with your API token"
    )
  }

  t <- if (!is.nothing(token))
    token
  else
    (if (is.nothing(props["token", 1]))
      token
      else
        props["token", 1])

  me <- list(
    token = t,
    baseDWApiUrl = baseDWApiUrl,
    baseQueryApiUrl = baseQueryApiUrl,
    baseDownloadApiUrl = baseDownloadApiUrl
  )
  class(me) <- "data.world"

  data.world::set_config(data.world::cfg(auth_token = t))

  return(me)
  }

#' @export
query.data.world <- function(connection, ...) {
  # Internal function to help unpack '...' param
  legacy_query_fun <- function(connection,
    type = "sql",
    dataset,
    query,
    queryParameters = list(),
    ...) {
    .Deprecated(
      new = "data.world::query",
      package = "data.world",
      msg = "The connection argument, of type data.world,
      is no longer necessary. See ?data.world::query for new usage."
    )

    if (type == "sparql") {
      return(data.world::query(
        data.world::qry_sparql(query_string = query, params = queryParameters),
        dataset
      ))
    } else {
      return(data.world::query(
        data.world::qry_sql(query_string = query, params = queryParameters),
        dataset
      ))
    }
  }

  return(legacy_query_fun(connection, ...))
}
