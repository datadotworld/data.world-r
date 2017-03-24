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

#' delete a file from the dataset
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param name the filename including the file extension. If a file by that name already
#' exists in the dataset, the file will be updated/overwritten.
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::deleteFileAndSyncSources(connection, dataset = "ownerid/datasetid",
#'  name = "file.csv")
#' @export
deleteFileAndSyncSources <- function(connection, dataset, name) {
  UseMethod("deleteFileAndSyncSources")
}

#' @export
deleteFileAndSyncSources.default <- function(connection, dataset, name) {
  print("nope")
}

#' @export
deleteFileAndSyncSources.data.world <- function(connection, dataset, name) {
  apiUrl = sprintf("%sdatasets/%s/files/%s", connection$baseDWApiUrl, dataset, name)
  auth = sprintf("Bearer %s", connection$token)
  response <- httr::DELETE( apiUrl,
                          httr::add_headers(
                            "Authorization" = auth),
                          httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  } else {
    ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
  }
  ret
}


#' delete a file from the dataset
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param names list names
#' @examples
#' connection <- data.world(token = "YOUR_API_TOKEN_HERE")
#' data.world::deleteFilesAndSyncSources(connection, dataset = "ownerid/datasetid",
#' names = list("file1.csv", "file2.csv"))
#' @export
deleteFilesAndSyncSources <- function(connection, dataset, names) {
  UseMethod("deleteFilesAndSyncSources")
}

#' @export
deleteFilesAndSyncSources.default <- function(connection, dataset, names) {
  print("nope")
}

#' @export
deleteFilesAndSyncSources.data.world <- function(connection, dataset, names) {
  queryParam <- lapply(names, function(name) sprintf("name=%s",name))
  if (length(queryParam) == 0) {
    print("empty names input = no-op")
  } else {
    apiUrl = paste(sprintf("%sdatasets/%s/files?", connection$baseDWApiUrl, dataset) , paste0(queryParam, collapse = "&"), sep = "")
    auth = sprintf("Bearer %s", connection$token)
    response <- httr::DELETE( apiUrl,
                              httr::add_headers(
                                "Authorization" = auth
                              ),
                              httr::user_agent(data.world::userAgent()))
    ret <- httr::http_status(response)
    if (response$status_code == 200) {
      ret <- data.world::SuccessMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
    } else {
      ret <- data.world::ErrorMessage(rjson::fromJSON(httr::content(x=response, as='text', encoding = "UTF-8")))
    }
    ret
  }
}
