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

#' FileCreateOrUpdateRequest per https://api.data.world/v0/swagger.json
#' @param name the filename including the file extension. If a file by that name already
#' exists in the dataset, the file will be updated/overwritten.
#' @param url the public, full direct-download path to file
#' @examples
#' fileCreateOrUpdateRequest <- data.world::FileCreateOrUpdateRequest(name = "file.csv",
#'  url = "https://data.world/file.csv")
#' @export
FileCreateOrUpdateRequest <- function(name, url) {
  if (name == '' | url == '') {
    stop("name, url are required")
  }
  source <- data.world::FileSourceCreateRequest(url)
  me <- list(
    name = name,
    source = source
  )
  class(me) <- "FileCreateOrUpdateRequest"
  return(me)
}

#' FileCreateOrUpdateRequest per https://api.data.world/v0/swagger.json
#' @param name the filename including the file extension. If a file by that name already
#' exists in the dataset, the file will be updated/overwritten.
#' @param url the public, full direct-download path to file
#' @examples
#' fileCreateRequest <- data.world::FileCreateRequest(name = "file.csv",
#'  url = "https://data.world/file.csv")
#' @export
FileCreateRequest <- function(name, url) {
  if (name == '' | url == '') {
    stop("name, url are required")
  }
  source <- data.world::FileSourceCreateRequest(url)
  me <- list(
    name = name,
    source = source
  )
  class(me) <- "FileCreateRequest"
  return(me)
}
