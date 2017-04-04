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

#' Look up types support across platform
#'
#' @param r a valid R type (optional)
#' @param ... any additional platforms
#' @param datapackage a valid datapackage type per http://frictionlessdata.io/data-packages/ (optional)
#' @param sparql a valid sparql type per https://www.w3.org/TR/rdf-sparql-query/#abbrevRdfType (optional)
#'
#' @return given a type in one platform , this function return the corresponding types from other
#'  supported platform
#' @examples
#'  allType <- data.world::datatypes()
#' @export
datatypes <- function(r=NULL, datapackage=NULL, sparql=NULL, ...) {
  if (is.null(r) && is.null(datapackage) && is.null(sparql) && length(list(...)) == 0) {
    return(masterTable)
  }
  keys <- list(...)
  keys['r'] <- r
  keys['datapackage'] <- datapackage
  keys['sparql'] <- sparql
  result = masterTable
  for (key in names(keys)) {
    result = result[result[[key]] == keys[[key]], ]
  }
  return(result)
}

sparqlType <- function(type) {
  return(sprintf("http://www.w3.org/2001/XMLSchema#%s", type))
}

masterTable <- data.frame("r"=c('logical', 'numeric', 'integer', 'character', 'date', 'POSIXlt', 'time'),
                           "datapackage"=c('boolean', 'number', 'integer', 'string' , 'date', 'datetime', 'time'),
                          "sparql"=unlist(lapply(c('boolean', 'decimal', 'integer', 'string', 'date', 'dateTime', 'dateTime'), sparqlType))
                           )



