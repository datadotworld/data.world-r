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

#' FileSourceCreateRequest per https://api.data.world/v0/swagger.json
#' @param url the public, full direct-download path to file
#' @examples
#' fileSourceCreateRequest <- data.world::FileSourceCreateRequest(
#' "https://open.obamawhitehouse/file3.csv")
#' @export
FileSourceCreateRequest <- function(url) {
  source <- data.world::FileSourceCreateOrUpdateRequest(url)
  # FileSourceCreateRequest
  class(source) = "FileSourceCreateRequest"
  return(source)
}

#' FileSourceCreateOrUpdateRequest per https://api.data.world/v0/swagger.json
#' @param url the public, full direct-download path to file
#'
#' @examples
#' fileSourceCreateOrUpdateRequest <- data.world::FileSourceCreateOrUpdateRequest(
#' "https://open.obamawhitehouse/file3.csv")
#' @export
FileSourceCreateOrUpdateRequest <- function(url) {
  if (url == '') {
    stop("url is required")
  }
  source <- list (
    url = url
  )
  # FileSourceCreateOrUpdateRequest
  class(source) = "FileSourceCreateOrUpdateRequest"
  return(source)
}
