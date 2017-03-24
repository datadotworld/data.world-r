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

#' Replace an existing dataset.
#' @param connection the connection to data.world
#'
#' @param datasetPutRequest a \code{\link{DatasetPutRequest}}
#' @param datasetid the "agentid/datasetid" for the dataset against which
#' to execute the query
#' @examples
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#' datasetPutRequest <- data.world::DatasetPutRequest(visibility = "OPEN",
#'  description = "UPDATED DESCRIPTION !")
#' data.world::replaceDataset(connection = conn, datasetPutRequest,
#'  "agentid/datasetid")
#' @export
replaceDataset <- function(connection, datasetPutRequest, datasetid) {
  UseMethod("replaceDataset")
}

#' @export
replaceDataset.default <- function(connection, datasetPutRequest, datasetid) {
  print("nope.")
}

#' @export
replaceDataset.data.world <- function(connection, datasetPutRequest, datasetid) {
  url = sprintf("%sdatasets/%s", connection$baseDWApiUrl, datasetid)
  message(url)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::PUT( url,
                         body = rjson::toJSON(datasetPutRequest),
                         httr::add_headers(
                           "Content-Type" = "application/json",
                           "Authorization" = auth),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200 | response$status_code == 202) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  }
  ret
}
