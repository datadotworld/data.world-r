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

#' publish a single file on the web to be added to a data.world dataset
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param name the filename including the file extension. If a file by that name already
#'  exists in the dataset, the file will be updated/overwritten.
#' @param url the public, full direct-download path to file
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::addFileBySource(connection, dataset = "ownerid/datasetid",
#'     name = "file.csv", url = "https://data.world/some_file.csv")
#' @export
addFileBySource <- function(connection, dataset, name, url) {
  UseMethod("addFileBySource")
}

#' @export
addFileBySource.default <- function(connection, dataset, name, url) {
  print("nope.")
}

#' @export
addFileBySource.data.world <- function(connection, dataset, name, url) {
  request <- data.world::FileBatchUpdateRequest()
  request <- data.world::addFile(request = request, name = name, url = url)
  ret <- data.world::addFilesBySource(connection = connection, dataset = dataset, fileBatchUpdateRequest = request)
  ret
}

#' publish file(s) on the web to be added to a data.world dataset via
#' `data.world::FileBatchUpdateRequest`
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param fileBatchUpdateRequest a requet of type `data.world::FileBatchUpdateRequest`
#' @examples
#' request <- data.world::FileBatchUpdateRequest()
#' request <- data.world::addFile(request = request, name = "file.csv",
#'      url = "https://data.world/some_file.csv")
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::addFilesBySource(connection, dataset = "ownerid/datasetid",
#'      fileBatchUpdateRequest = request)
#' @export
addFilesBySource <- function(connection, dataset, fileBatchUpdateRequest) {
  UseMethod("addFilesBySource")
}

#' @export
addFilesBySource.default <- function(connection, dataset, fileBatchUpdateRequest) {
  print("nope.")
}

#' @export
addFilesBySource.data.world <- function(connection, dataset, fileBatchUpdateRequest) {
  apiUrl = sprintf("%sdatasets/%s/files", connection$baseDWApiUrl, dataset)
  contentTypeHeader <- "application/json"
  authHeader = sprintf("Bearer %s", connection$token)
  response <- httr::POST( apiUrl,
                          body = rjson::toJSON(fileBatchUpdateRequest),
                          httr::add_headers(
                            "Content-Type" = contentTypeHeader,
                            "Authorization" = authHeader),
                          httr::progress(),
                          httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200 | response$status_code == 202) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  }
  ret
}
