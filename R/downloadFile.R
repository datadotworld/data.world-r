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

#' Download file from the latest dataset version
#' @param connection the connection to data.world
#' @param dataset    the "agentid/datasetid" for the dataset against
#' which to execute the query
#' @param fileName the filename as listed in the data.world dataset
#' @param output the local file to store the downloaded content
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' downloadFile(connection, dataset="ownerid/datasetid" , fileName = "file.csv",
#' output = "tmp/file.csv")
#' @export
downloadFile <- function(connection, dataset, fileName, output) {
  UseMethod("downloadFile")
}

#' @export
downloadFile.default <- function(connection, dataset, fileName, output) {
  print("nope.")
}

#' @export
downloadFile.data.world <- function(connection, dataset, fileName, output) {
  url = sprintf("%s/file_download/%s/%s", connection$baseDownloadApiUrl, dataset, fileName)
  response <- httr::GET( url,
                         httr::add_headers(
                           Authorization = sprintf("Bearer %s", connection$token)),
                         httr::progress(),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    raw <- httr::content(x=response, as='raw')
    writeBin(raw, output)
  } else {
    message(sprintf("%s return %s", url, response$status_code))
  }
  ret
}
