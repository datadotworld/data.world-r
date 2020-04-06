"data.world-r
Copyright 2018 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.
https://data.world"

#' Defunct function(s) in the data.world package
#'
#' These functions have been removed from the data.world package.
#' @rdname data.world-defunct
#' @name data.world-defunct
#' @aliases query.data.world
#' @docType package
#' @section A note on data.world vs. dwapi:
#'     Most of these defunct functions are low-leve REST API
#'     endpoint wrappers and
#'     have been renamed for consistency and moved to the dwapi package in
#'     order to keep the data.world namespce as clean as possible.
#' @section Details:
#' \tabular{ll}{
#'    \code{data.world} \tab is replaced by \code{\link{set_config}}\cr
#'    \code{query.data.world} \tab is replaced by \code{\link{query}}\cr
#'    \code{addFile} \tab is now \code{\link[dwapi]{add_file}}\cr
#'    \code{addFileBySource} \tab is
#'    now \code{\link[dwapi]{add_file_by_source}}\cr
#'    \code{addFilesBySource} \tab is
#'    now \code{\link[dwapi]{add_files_by_source}}\cr
#'    \code{createDataset} \tab is
#'    now \code{\link[dwapi]{create_dataset}}\cr
#'    \code{deleteFileAndSyncSources} \tab is
#'    now \code{\link[dwapi]{delete_file}}\cr
#'    \code{deleteFilesAndSyncSources} \tab is
#'    now \code{\link[dwapi]{delete_files}}\cr
#'    \code{downloadFile} \tab is now \code{\link[dwapi]{download_file}}\cr
#'    \code{downloadFileAsDataFrame} \tab is
#'    now \code{\link[dwapi]{download_file_as_data_frame}}\cr
#'    \code{getDataset} \tab is now \code{\link[dwapi]{get_dataset}}\cr
#'    \code{patchDataset} \tab is now \code{\link[dwapi]{update_dataset}}\cr
#'    \code{replaceDataset} \tab is now \code{\link[dwapi]{replace_dataset}}\cr
#'    \code{syncDataset} \tab is now \code{\link[dwapi]{sync}}\cr
#'    \code{uploadDataFrame} \tab is
#'    now \code{\link[dwapi]{upload_data_frame}}\cr
#'    \code{uploadFile} \tab is now \code{\link[dwapi]{upload_file}}\cr
#'    \code{uploadFiles} \tab is now \code{\link[dwapi]{upload_files}}\cr
#'    \code{DatasetCreateRequest} \tab is
#'    now \code{\link[dwapi]{dataset_create_request}}\cr
#'    \code{DatasetPatchRequest} \tab is
#'    now \code{\link[dwapi]{dataset_update_request}}\cr
#'    \code{DatasetPutRequest} \tab is
#'    now \code{\link[dwapi]{dataset_replace_request}}\cr
#'    \code{FileBatchUpdateRequest} \tab is
#'    now \code{\link[dwapi]{file_batch_update_request}}\cr
#'    \code{FileCreateOrUpdateRequest} \tab is
#'    now \code{\link[dwapi]{file_create_or_update_request}}\cr
#' }
#' @seealso \link[dwapi]{dwapi}
NULL

#' @export
# nolint start
data.world <- function(token = NULL,
  propsfile = sprintf("%s/.data.world", path.expand("~")),
  baseDWApiUrl = "https://api.data.world/v0/",
  baseQueryApiUrl = "https://query.data.world/",
  baseDownloadApiUrl = "https://download.data.world") {
  .Defunct("data.world::set_config", "data.world")

  is.nothing <- function(x)
    is.null(x) || is.na(x) || is.nan(x)

  if (file.exists(propsfile)) {
    props <-
      utils::read.table(
        propsfile,
        header = FALSE,
        sep = "=",
        row.names = 1,
        strip.white = TRUE,
        na.strings = "NA",
        stringsAsFactors = FALSE
      )
  } else {
    props <- data.frame()
  }

  if (is.nothing(token) && is.nothing(props["token", 1])) {
    stop(
      "you must either provide an API token to this constructor, or create a
      .data.world file in your home directory with your API token"
    )
  }

  t <- if (!is.nothing(token))
    token
  else
    (if (is.nothing(props["token", 1]))
      token
      else
        props["token", 1])

  me <- list(
    token = t,
    baseDWApiUrl = baseDWApiUrl,
    baseQueryApiUrl = baseQueryApiUrl,
    baseDownloadApiUrl = baseDownloadApiUrl
  )
  class(me) <- "data.world"

  data.world::set_config(data.world::cfg(auth_token = t))

  return(me)
}
# nolint end
