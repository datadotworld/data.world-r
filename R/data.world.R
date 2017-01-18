# data.world client library
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

library(httr)
library(readr)

#' data.world client constructor
#' @param token your data.world API token
#'
#' @return a data.world client
#' @export
data.world <- function(token) {
  thisEnv <- environment()
  token = token
  me <- list(
    thisEnv = thisEnv,
    getToken =
      #' @rdname getToken
      #' @export
      function() {
        return(get("token", thisEnv))
      },
    query =
      #' @rdname query
      #' @export
      #'
      #' @param type     the type of the query - either "sql" or "sparql"
      #' @param dataset  the "agentid/datasetid" for the dataset against which to execute the query
      #' @param query    the SQL or SPARQL query to run
      #'
      #' @return the query results as a data frame
      function(type="sql", dataset, query) {
        "execute a SQL or SPARQL query against a data.world dataset"
        url = sprintf("https://query.data.world/%s/%s", type, dataset)
        response <- GET( url,
                         query = list(query = query),
                         add_headers(
                           Accept = "text/csv",
                           Authorization = sprintf("Bearer %s", get("token", thisEnv))
                         ))
        content(response)
      }
  )
  assign('this',me,envir=thisEnv)
  class(me) <- append(class(me), "data.world")
  return(me)
}
