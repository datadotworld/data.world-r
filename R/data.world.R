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
data.world <- function(profileName = "default") {
  data.world::assertConfig()
  profile <- DW_PROFILES[[profileName]]
  apiClient <- list(
    token = profile$token,
    baseDWApiUrl = profile$baseDWApiUrl,
    baseDownloadApiUrl = profile$baseDownloadApiUrl,
    baseQueryApiUrl = profile$baseQueryApiUrl
  )
  class(apiClient) <- 'ApiClient'
  me <- list(
    token = profile$token,
    baseDWApiUrl = profile$baseDWApiUrl,
    baseQueryApiUrl = profile$baseQueryApiUrl,
    baseDownloadApiUrl = profile$baseDownloadApiUrl,
    apiClient = apiClient
    )
  class(me) <- "data.world"
  return(me)
}


#' @export
loadDataset <- function(x, datasetKey) {
  UseMethod("loadDataset", x)
}

#' Declare and load a dataset dependency
#'
#' @param datadotworld a data.world sdk client
#' @param datasetKey a data.world dataset url e.g https://data.world/jonloyens/an-intro-to-dataworld-dataset
#' @examples
#' \dontrun{
#' data.world::loadDataset(data.world(), 'https://data.world/jonloyens/an-intro-to-dataworld-dataset')
#' }
#' @export
loadDataset.data.world <- function(datadotworld, datasetKey) {
  return(downloadDatapackage(datadotworld$apiClient, datasetKey))
}

