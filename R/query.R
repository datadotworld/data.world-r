#' execute a SQL or SPARQL query against a data.world client
#'
#' @param connection the connection to data.world
#' @param type       the type of the query - either "sql" or "sparql"
#' @param dataset    the "agentid/datasetid" for the dataset against which to execute the query
#' @param query      the SQL or SPARQL query to run
#'
#' @return the query results as a data frame
#' @seealso \code{\link{data.world}}
#' @export
query <- function(connection, type, dataset, query) {
  UseMethod("query")
}

#' @export
query.default <- function(connection, type, dataset, query) {
  print("nope.")
}

#' @export
query.data.world <- function(connection, type = "sql", dataset, query) {
  url = sprintf("https://query.data.world/%s/%s", type, dataset)
  response <- httr::GET( url,
                   query = list(query = query),
                   httr::add_headers(
                     Accept = "text/csv",
                     Authorization = sprintf("Bearer %s", connection$token)
                   ))
  if (response$status_code == 200) return(httr::content(response))
  httr::http_status(response)
}
