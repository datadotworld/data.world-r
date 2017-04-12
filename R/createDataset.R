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
createDataset <- function(object, ...) {
  UseMethod("createDataset")
}

#' @export
createDataset.default <- function(object, ...) {
  print("nope.")
}

#' create a dataset and add metadata
#' @param apiClient a data.world client
#'
#' @param createDatasetRequest the request payload
#' @param ownerId Dataset owner username. Included in data.world dataset URL path, after domain.
#' @examples
#' request <- data.world::DatasetCreateRequest(title="testdataset", visibility = "OPEN",
#'      description = "Test Dataset by R-SDK" , tags = c("rsdk", "sdk", "arr") ,
#'      licenseString = "Public Domain")
#' request <- data.world::addFile(request = request, name = "file4.csv",
#'      url = "https://data.world/file4.csv")
#' data.world::createDataset(apiClient = data.world()$apiClient, createDatasetRequest = request,
#'      ownerId = "ownerid")
#' @export
createDataset.ApiClient <- function(apiClient, createDatasetRequest, ownerId) {
  url = sprintf("%sdatasets/%s", apiClient$baseDWApiUrl, ownerId)
  auth = sprintf("Bearer %s", apiClient$token)
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
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  }
  ret
}
