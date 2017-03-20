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

#' Retrieve a dataset via data.world public api
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @return the data.world dataset's metadata
#' @seealso https://docs.data.world/documentation/api/
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' getDataset(connection, dataset="user/dataset")
#' @export
getDataset <- function(connection, dataset) {
  UseMethod("getDataset")
}

#' @export
getDataset.default <- function(connection, dataset) {
  print("nope.")
}

#' @export
getDataset.data.world <- function(connection, dataset) {
  url = sprintf("%sdatasets/%s", connection$baseDWApiUrl, dataset)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::GET(
    url,
    httr::add_headers("Content-Type" = "application/json",
                      "Authorization" = auth),
    httr::user_agent(data.world::userAgent())
  )
  if (response$status_code == 200) {
    structuredResponse <-
      rjson::fromJSON(httr::content(x = response, as = 'text', encoding = "UTF-8"))
    ret <- data.world::DatasetSummaryResponse(structuredResponse)
  } else {
    ret <-
      data.world::ErrorMessage(rjson::fromJSON(httr::content(x = response,
                                                             as = 'text',
                                                             encoding = "UTF-8")))
  }
  ret
}
