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
deleteFileAndSyncSources <- function(object, ...) {
  UseMethod("deleteFileAndSyncSources")
}

#' @export
deleteFileAndSyncSources.default <- function(object, ...) {
  print("nope")
}

#' delete a file from the dataset
#' @param apiClient a data.world api client
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param name the filename including the file extension. If a file by that name already
#' exists in the dataset, the file will be updated/overwritten.
#' @examples
#' data.world::deleteFileAndSyncSources(data.world()$apiClient, dataset = "ownerid/datasetid",
#'  name = "file.csv")
#' @export
deleteFileAndSyncSources.ApiClient <- function(apiClient, dataset, name) {
  apiUrl = sprintf("%sdatasets/%s/files/%s", apiClient$baseDWApiUrl, dataset, name)
  auth = sprintf("Bearer %s", apiClient$token)
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



#' @export
deleteFilesAndSyncSources <- function(object, ...) {
  UseMethod("deleteFilesAndSyncSources")
}

#' @export
deleteFilesAndSyncSources.default <- function(object, ...) {
  print("nope")
}

#' delete a file from the dataset
#' @param apiClient a data.world api client
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param names list names
#' @examples
#' data.world::deleteFilesAndSyncSources(data.world()$apiClient, dataset = "ownerid/datasetid",
#' names = list("file1.csv", "file2.csv"))
#' @export
deleteFilesAndSyncSources.ApiClient <- function(apiClient, dataset, names) {
  queryParam <- lapply(names, function(name) sprintf("name=%s",name))
  if (length(queryParam) == 0) {
    print("empty names input = no-op")
  } else {
    apiUrl = paste(sprintf("%sdatasets/%s/files?", apiClient$baseDWApiUrl, dataset) , paste0(queryParam, collapse = "&"), sep = "")
    auth = sprintf("Bearer %s", apiClient$token)
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
