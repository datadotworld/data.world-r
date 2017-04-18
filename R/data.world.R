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

#' data.world: A package for interacting with data.world platform.
#'
#'
#' @section data.world functions:
#' The main SDK expose 2 functions :
#' \enumerate{
#'   \item Declare and load a dataset dependency via \code{\link{loadDataset}}
#'   \item Execute query via \code{\link{query}}
#' }
#' @docType package
#' @name data.world

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

#' Declare and load a dataset dependency
#'
#' @param datasetKey a data.world dataset url e.g https://data.world/jonloyens/an-intro-to-dataworld-dataset
#' @examples
#' \dontrun{
#' dataset <- data.world::loadDataset('https://data.world/jonloyens/an-intro-to-dataworld-dataset')
#' summary(dataset)
#' names(dataset$tables)
#' dataset$tables$datadotworldbballstats
#' }
#' @return return a structure of class \code{\link{data.world::LocalDataset}}
#' @export
loadDataset<- function(datasetKey) {
  return(downloadDatapackage(data.world()$apiClient, datasetKey))
}

