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

#' Add a file to a container
#' @param request some object with a file container
#' @param name the filename including the file extension. If a file by that name
#' already exists in the dataset, the file will be updated/overwritten.
#' @param url the public, full direct-download path to file
#' @examples
#' fileBatchUpdateRequest <- data.world::FileBatchUpdateRequest()
#'
#' fileBatchUpdateRequest <- data.world::addFile(request = fileBatchUpdateRequest,
#'    name = "file.csv", url = "https://data.world/file3.csv")
#'
#' createDatasetRequest <- data.world::DatasetCreateRequest(title="coffeeCounty",
#'     visibility = "OPEN", description = "coffee county , AL - census income" ,
#'     tags = c("rsdk", "sdk", "arr") , licenseString = "Public Domain")
#'
#' createDatasetRequest <- data.world::addFile(request = createDatasetRequest,
#'     name = "file4.csv", url = "https://data.world/file4.csv")
#'
#' datasetPutRequest <- data.world::DatasetPutRequest(visibility = "OPEN",
#'     description = "updated description", files = list())
#'
#' datasetPutRequest <- data.world::addFile(request = datasetPutRequest,
#'     name = "file4.csv", url = "https://data.world/file4.csv")
#' @export
addFile <- function(request, name, url) {
  UseMethod("addFile")
}

#' @export
addFile.default <- function(request, name, url) {
  print("nope.")
}

#' @export
addFile.FileBatchUpdateRequest <- function(request, name, url) {
  existingFiles = request$files
  # O(N) ?
  existingFiles[[length(existingFiles) + 1]] <- data.world::FileCreateOrUpdateRequest(name, url)
  request$files = existingFiles
  request
}

#' @export
addFile.DatasetCreateRequest <- function(request, name, url) {
  existingFiles = request$files
  # O(N) ?
  existingFiles[[length(existingFiles) + 1]] <- data.world::FileCreateRequest(name, url)
  request$files = existingFiles
  request
}

#' @export
addFile.DatasetPutRequest <- function(request, name, url) {
  existingFiles = request$files
  # O(N) ?
  existingFiles[[length(existingFiles) + 1]] <- data.world::FileCreateRequest(name, url)
  request$files = existingFiles
  request
}

#' @export
addFile.DatasetPatchRequest <- function(request, name, url) {
  existingFiles = request$files
  # O(N) ?
  existingFiles[[length(existingFiles) + 1]] <- data.world::FileCreateOrUpdateRequest(name, url)
  request$files = existingFiles
  request
}
