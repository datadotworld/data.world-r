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

#' Update an existing dataset.
#' @param connection the connection to data.world
#'
#' @param datasetPatchRequest a \code{\link{DatasetPatchRequest}}
#' @param datasetid the "agentid/datasetid" for the dataset against
#' which to execute the query
#' @examples
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#'
#' request <- data.world::DatasetPatchRequest(visibility = "OPEN",
#' description = "UPDATED DESCRIPTION !")
#'
#' data.world::patchDataset(connection = conn, datasetPatchRequest = request,
#'  datasetid = "agentid/datasetid")
#' @export
patchDataset <- function(connection, datasetPatchRequest, datasetid) {
  UseMethod("patchDataset")
}

#' @export
patchDataset.default <- function(connection, datasetPatchRequest, datasetid) {
  print("nope.")
}

#' @export
patchDataset.data.world <- function(connection, datasetPatchRequest, datasetid) {
  url = sprintf("%sdatasets/%s", connection$baseDWApiUrl, datasetid)
  message(url)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::PATCH( url,
                         body = rjson::toJSON(datasetPatchRequest),
                         httr::add_headers(
                           "Content-Type" = "application/json",
                           "Authorization" = auth),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200 | response$status_code == 202) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}
