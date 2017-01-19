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

#' execute a SQL or SPARQL query against a data.world client
#'
#' @param connection the connection to data.world
#' @param type       the type of the query - either "sql" or "sparql"
#' @param dataset    the "agentid/datasetid" for the dataset against which to execute the query
#' @param query      the SQL or SPARQL query to run
#'
#' @return the query results as a data frame
#' @seealso \code{\link{data.world}}
#' @examples
#' query(connection, dataset="user/dataset",
#'       query="SELECT *
#'                FROM TableName
#'               LIMIT 10")
#' query(connection, dataset="user/dataset", type="sparql",
#'       query="SELECT *
#'              WHERE {
#'                ?s ?p ?o.
#'              } LIMIT 10")
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
