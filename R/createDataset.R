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

#' create a dataset and add metadata
#' @param connection the connection to data.world
#'
#' @param createDatasetRequest the request payload
#' @param ownerId Dataset owner username. Included in data.world dataset URL path, after domain.
#' @examples
#' request <- data.world::DatasetCreateRequest(title="testdataset", visibility = "OPEN",
#'      description = "Test Dataset by R-SDK" , tags = c("rsdk", "sdk", "arr") ,
#'      licenseString = "Public Domain")
#'
#' request <- data.world::addFile(request = request, name = "file4.csv",
#'      url = "https://data.world/file4.csv")
#'
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#'
#' data.world::createDataset(connection = conn, createDatasetRequest = request,
#'      ownerId = "ownerid")
#' @export
createDataset <- function(connection, createDatasetRequest, ownerId) {
  UseMethod("createDataset")
}

#' @export
createDataset.default <- function(connection, createDatasetRequest, ownerId) {
  print("nope.")
}

#' @export
createDataset.data.world <- function(connection, createDatasetRequest, ownerId) {
  url = sprintf("%sdatasets/%s", connection$baseDWApiUrl, ownerId)
  auth = sprintf("Bearer %s", connection$token)
  acceptHeader = "application/json"
  contentType = "application/json"
  response <- httr::POST( url,
                          body = rjson::toJSON(createDatasetRequest),
                          httr::add_headers(
                            "Accept" = acceptHeader,
                            "Content-Type" = contentType,
                            "Authorization" = auth
                          ), httr::progress(),
                          httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200 | response$status_code == 202) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}
