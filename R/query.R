"data.world-r
Copyright 2018 data.world, Inc.

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

#' Execute a query on data.world.
#'
#' @param qry Query object of type qry_sql or qry_sparql.
#' @param ... S3 method specific params.
#' @return Query results as a data frame.
#' @seealso \code{\link{sql}} \code{\link{sparql}}
#' @export
query <- function(qry, ...) {
  UseMethod("query")
}

#' @export
query.default <- function(qry, ...) {
  print("nope.")
}

#' @describeIn query Execute a SQL query on data.world.
#' @param ... either a single parameter \code{dataset} that is a full
#' URL to a data.world dataset or a qualified dataset reference of the form
#' owner/dataset, OR separate parameters \code{owner_id} and
#' \code{dataset_id}
#' @examples
#' \dontrun{
#'   sql_stmt <- data.world::qry_sql("SELECT * FROM Tables")
#'   query_results_df <- data.world::query(
#'     sql_stmt, "jonloyens", "an-intro-to-dataworld-dataset")
#' }
#' @export
query.qry_sql <- function(qry, ...) {

  # Internal function to help unpack "..." param
  # TODO Promote dataset param to S3 generic when query.data.world is removed

  params <- list(...)
  params <- extract_dataset_parts(params)

  dwapi::sql(
    owner_id = params$owner_id,
    dataset_id = params$dataset_id,
    query = qry$query_string,
    query_params = qry$params
  )

}

#' @describeIn query Execute a SPARQL query on data.world.
#' @param ... either a single parameter \code{dataset} that is a full
#' URL to a data.world dataset or a qualified dataset reference of the form
#' owner/dataset, OR separate parameters \code{owner_id} and
#' \code{dataset_id}
#' @examples
#' \dontrun{
#'   sparql_stmt <- data.world::qry_sparql("SELECT ?s ?p ?o
#'                                          WHERE {
#'                                            ?s ?p ?o.
#'                                          }")
#'   query_results_df <- data.world::query(
#'     sparql_stmt, "jonloyens", "an-intro-to-dataworld-dataset")
#' }
#' @export
query.qry_sparql <- function(qry, ...) {

  # Internal function to help unpack "..." param
  # TODO Promote dataset param to S3 generic when query.data.world is removed

  params <- list(...)
  params <- extract_dataset_parts(params)

  dwapi::sparql(
    owner_id = params$owner_id,
    dataset_id = params$dataset_id,
    query = qry$query_string,
    query_params = qry$params
  )

}

#' Constructor function for SQL queries.
#'
#' @param query_string SQL query string.
#' @param params Sequence of positional query parameters.
#' @return Object of type \code{qry_sql}.
#' @examples
#' \dontrun{
#'   sql_stmt <- data.world::qry_sql("SELECT * FROM Tables")
#' }
#' @export
qry_sql <- function(query_string, params = NULL) {
  me <- list(query_string = query_string, params = params)
  class(me) <- "qry_sql"
  return(me)
}

#' Constructor function for SPARQL queries.
#'
#' @param query_string SPARQL query string.
#' @param params Sequence of named query parameters.
#' @return Object of type \code{qry_sparql}.
#' @examples
#' \dontrun{
#'   sparql_stmt <- data.world::qry_sparql("SELECT ?s ?p ?o
#'                                          WHERE {
#'                                            ?s ?p ?o.
#'                                          }")
#' }
#' @export
qry_sparql <- function(query_string, params = NULL) {
  me <- list(query_string = query_string, params = params)
  class(me) <- "qry_sparql"
  return(me)
}

extract_dataset_parts <- function(params) {

  ret <- list()

  if (length(params) == 1) {
    param <- params[[1]]
    param <- extract_dataset_key(param)
    p <- "(.+)/(.+)"
    if (!grepl(x = param, pattern = p)) {
      stop(paste0("Dataset reference must be of the form owner_id/dataset_id, not ", param)) #nolint
    }
    ret$owner_id <- gsub(x = param, pattern = p, replacement = "\\1")
    ret$dataset_id <- gsub(x = param, pattern = p, replacement = "\\2")
  } else if (length(params) == 2) {
    if (is.null(names(params))) {
      ret$owner_id <- params[[1]]
      ret$dataset_id <- params[[2]]
    } else {
      ret$owner_id <- params$owner_id
      ret$dataset_id <- params$dataset_id
      if (is.null(ret$owner_id) | is.null(ret$dataset_id)) {
        stop("If named parameters are provided, there must be exactly two with the names owner_id and dataset_id") #nolint
      }
    }
  }

  ret

}
