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


#' @export
query <- function(object, ...) {
  UseMethod("query", object)
}

#' @export
query.default <- function(object, ...) {
  print("nope.")
}


#' execute a SQL or SPARQL query against a data.world client
#'
#' @param datadotworld a data.world sdk cient
#' @param type       the type of the query - either "sql" or "sparql"
#' @param datasetKey a data.world dataset url e.g https://data.world/jonloyens/an-intro-to-dataworld-dataset
#' @param query      the SQL or SPARQL query to run .
#' @param queryParameters Optional comma-separated ?name=value pairs
#' @param ...  additional param
#' @return the query results as a data frame
#' @seealso \code{\link{data.world}}
#' @examples
#' query(data.world(), "https://data.world/user/dataset",
#'       query="SELECT *
#'                FROM TableName
#'               LIMIT 10")
#'
#' query(data.world(), "https://data.world/user/dataset",
#'       query="SELECT *
#'                FROM TableName where `field1` = ? AND `field2` > ?
#'               LIMIT 10",
#'       queryParameters = list("value", 5.0))
#'
#' query(data.world(), datasetKey = "https://data.world/user/dataset", type="sparql",
#'       query="SELECT *
#'              WHERE {
#'                ?s ?p ?o.
#'              } LIMIT 10")
#'
#' query(data.world(), datasetKey = "https://data.world/user/dataset", type="sparql",
#'       query="SELECT *
#'              WHERE {
#'              [ :Year ?year ; :Region ?region ; :Indicator_Coverage_and_Disaggregation ?score ]
#'              FILTER(?score > $v1)
#'              } LIMIT 10",
#'              queryParameters = list("$v1"=5.5))
#'
#' @export
query.data.world <- function(datadotworld, type = "sql", datasetKey, query, queryParameters = list(), ...) {
  parsedDatasetkey <- parseDatasetUrl(datasetKey)
  dataset <- sprintf('%s/%s', parsedDatasetkey$ownerid, parsedDatasetkey$datasetid)
  url = sprintf("https://query.data.world/%s/%s", type, dataset)
  requestQuery = list(query = query)
  if (length(queryParameters) > 0) {
    if (type == "sparql") {
      requestQuery$parameters <- contructQueryParameterString(queryParameters)
    } else {
      namedQueryParmeters <- list()
       for (i in 0:(length(queryParameters)-1)) {
          namedQueryParmeters[[paste("$data_world_param",i, sep = "")]] <- queryParameters[[i+1]]
       }
      requestQuery$parameters <- contructQueryParameterString(namedQueryParmeters)
    }
  }
  response <- httr::GET( url,
                   query = requestQuery,
                   httr::add_headers(
                     Accept = "text/csv",
                     Authorization = sprintf("Bearer %s", datadotworld$token)),
                   httr::user_agent(data.world::userAgent()))
  #print(response)
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    text <- httr::content(x=response, as='text')
    df <- readr::read_csv(text, ...)
    ret <- df
  }
  ret
}

contructQueryParameterString <- function (queryParameterNamedList) {
  queryParameterStrings = lapply(names(queryParameterNamedList), function (param) {
    sparqlLiteral <- convertToSparqlLiteral(queryParameterNamedList[[param]])
    paste(param, sparqlLiteral, sep = "=")
  })
  ret <- paste(queryParameterStrings, collapse = ",")
  ret
}

convertToSparqlLiteral <- function (v) {
  type <- class(v)
  iriTemplate <- switch(type,
         "logical"="\"%s\"^^<http://www.w3.org/2001/XMLSchema#boolean>",
         "numeric"="\"%s\"^^<http://www.w3.org/2001/XMLSchema#decimal>",
         "integer"="\"%s\"^^<http://www.w3.org/2001/XMLSchema#integer>",
         "character"="\"%s\""
         )
  if(is.null(iriTemplate)) {
    stop(sprintf("parameter value %s is of not supported type %s. Supported types are logical, numeric, integer, character.", v, type))
  }
  return(sprintf(iriTemplate, v))
}
