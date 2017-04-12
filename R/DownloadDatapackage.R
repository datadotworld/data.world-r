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
downloadDatapackage <- function(x, ...) {
  UseMethod("downloadDatapackage", x)
}

#' return a data package of the latest dataset version.
#'
#' @description A data package is a standardized way
#'  to package data for simple sharing between tools and people. Learn more about
#'  the Data Package specification at frictionlessdata.io.
#'
#' @param apiClient a data.world apiClient
#' @param datasetKey a data.world dataset url e.g https://data.world/jonloyens/an-intro-to-dataworld-dataset
#' @param output the cache dir where we are storing the datapackage content
#' @examples
#' \dontrun{
#' data.world::downloadDatapackage(data.world()$apiClient , "https://data.world/ownerid/datasetid")
#' }
#' @export
downloadDatapackage.ApiClient <- function(apiClient, datasetKey) {
  parsedDatasetkey <- parseDatasetUrl(datasetKey)
  dataset <- sprintf('%s/%s', parsedDatasetkey$ownerid, parsedDatasetkey$datasetid)
  output <- sprintf("tmp/dp/%s", dataset)
  url = sprintf("%s/datapackage/%s", apiClient$baseDownloadApiUrl, dataset)
  response <- httr::GET( url,
                         httr::add_headers(
                           Authorization = sprintf("Bearer %s", apiClient$token)),
                         httr::progress(),
                         httr::user_agent(data.world::userAgent()))
  ret <- httr::http_status(response)
  if (response$status_code == 200) {
    raw <- httr::content(x=response, as='raw')
    if (dir.exists(output)) {
      unlink(output,  recursive = TRUE, force = TRUE)
    }
    message(output)
    dir.create(output, recursive = TRUE, showWarnings = FALSE)
    zipFileName <- sprintf("%s/datapackage.zip",output)
    writeBin(raw, zipFileName)
    # zip content is extracted into the snapshotted output dir
    extracted <- utils::unzip(zipFileName, overwrite = TRUE , exdir = output)
    datapackageJsonPath <- extracted[endsWith(extracted, "datapackage.json")]
    if (is.null(datapackageJsonPath) || length(datapackageJsonPath) == 0) {
      stop(sprintf("%s does not contain a datapackage.json file. Please contact data.world help desk and report a bug.", url))
    }
    return(data.world::LocalDataset(dataset = dataset, datapackagePath = datapackageJsonPath))
  } else {
    stop(sprintf("%s return %s", url, response$status_code))
  }
}

generateTimestamp <- function () {
  return(as.integer(as.POSIXct(Sys.time(), "UTC")))
}
