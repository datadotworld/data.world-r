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

#' Upload a file to a dataset
#'
#' @param connection the connection to data.world
#' @param path the file path you want to upload
#' @param fileName the filename (with extension) to be view in the dataset
#' @param dataset datasetid
#'
#' @return http response
#'
#' @examples
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#' df = data.frame(a = c(1,2,3),b = c(4,5,6))
#' write.csv(df, file = "file.csv")
#' uploadFile(connection = conn, fileName = "file.csv",
#' path = "file.csv", dataset = "ownerid/datasetid")
#' @export
uploadFile <- function(connection, path, fileName, dataset) {
  UseMethod("uploadFile")
}

#' @export
uploadFile.default <- function(connection, path, fileName, dataset) {
  print("nope.")
}

#' @export
uploadFile.data.world <- function(connection, path, fileName, dataset) {
  url = sprintf("%suploads/%s/files/%s", connection$baseDWApiUrl, dataset, fileName)
  auth = sprintf("Bearer %s", connection$token)
  contentType = "application/octet-stream"
  response <- httr::PUT( url,
                          body = httr::upload_file(path),
                          httr::add_headers(
                           "Content-Type" = contentType,
                           "Authorization" = auth
                         ), httr::progress(),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}

#' Upload one or more files to a dataset.
#'
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param paths the local file paths
#' @examples
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#' write.csv(data.frame(a = c(1,2,3),b = c(4,5,6)), file = "file1.csv")
#' write.csv(data.frame(c = c(1,2,3),d = c(4,5,6)), file = "file2.csv")
#' uploadFiles(connection = conn, dataset = "ownerid/datasetid",
#'  paths = list ("file1.csv", "file2.csv"))
#' @export
uploadFiles <- function(connection, dataset, paths) {
  UseMethod("uploadFiles")
}

#' @export
uploadFiles.default <- function(connection, dataset, paths) {
  print("nope.")
}

#' @export
uploadFiles.data.world <- function(connection, dataset, paths) {
  url = sprintf("%suploads/%s/files", connection$baseDWApiUrl, dataset)
  auth = sprintf("Bearer %s", connection$token)
  contentType = "multipart/form-data"
  bodyValues = lapply(paths, function(path) httr::upload_file(path))
  bodyNames = lapply(paths, function(path) "file")
  body = structure(bodyValues , names=bodyNames)
  response <- httr::POST( url,
                         body = body,
                         httr::add_headers(
                           "Content-Type" = contentType,
                           "Authorization" = auth
                         ),
                         httr::progress(),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text')))
  }
  ret
}
