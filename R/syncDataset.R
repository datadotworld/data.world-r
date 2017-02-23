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

#' Fetch latest files from source and update dataset via GET, for convenience.
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::syncViaGet(connection, dataset="user/dataset")
#' @export
syncViaGet <- function(connection, dataset) {
  UseMethod("syncViaGet")
}

#' @export
syncViaGet.default <- function(connection, dataset) {
  print("nope.")
}

#' @export
syncViaGet.data.world <- function(connection, dataset) {
  url = sprintf("%sdatasets/%s/sync", connection$baseDWApiUrl, dataset)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::GET( url,
                         httr::add_headers(
                           "Content-Type" = "application/json",
                           "Authorization" = auth),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}

#' Fetch latest files from source and update dataset
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::sync(connection, dataset="ownerid/dataset")
#' @export
sync <- function(connection, dataset) {
  UseMethod("sync")
}

#' @export
sync.default <- function(connection, dataset) {
  print("nope.")
}

#' @export
sync.data.world <- function(connection, dataset) {
  url = sprintf("%sdatasets/%s/sync", connection$baseDWApiUrl, dataset)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::POST( url,
                         httr::add_headers(
                           "Content-Type" = "application/json",
                           "Authorization" = auth),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}
