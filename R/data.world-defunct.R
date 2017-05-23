"data.world-r
Copyright 2017 data.world, Inc.

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
#' @aliases addFile addFileBySource addFilesBySource createDataset deleteFileAndSyncSources
#'     deleteFileAndSyncSources deleteFilesAndSyncSources downloadFile downloadFileAsDataframe
#'     getDataset patchDataset replaceDataset syncDataset uploadDataFrame uploadFile uploadFiles
#'     DatasetCreateRequest DatasetPatchRequest DatasetPutRequest FileBatchUploadRequest
#'     FileCreateOrUpdateRequest
#' @docType package
#' @section A note on data.world vs. dwapi:
#'     Most of these defunct functions are low-leve REST API endpoint wrappers and
#'     have been renamed for consistency and moved to the dwapi package in
#'     order to keep the data.world namespce as clean as possible.
#' @section Details:
#' \tabular{ll}{
#'    \code{addFile} \tab is now \code{\link[dwapi]{add_file}}\cr
#'    \code{addFileBySource} \tab is now \code{\link[dwapi]{add_file_by_source}}\cr
#'    \code{addFilesBySource} \tab is now \code{\link[dwapi]{add_files_by_source}}\cr
#'    \code{createDataset} \tab is now \code{\link[dwapi]{create_dataset}}\cr
#'    \code{deleteFileAndSyncSources} \tab is now \code{\link[dwapi]{delete_file}}\cr
#'    \code{deleteFilesAndSyncSources} \tab is now \code{\link[dwapi]{delete_files}}\cr
#'    \code{downloadFile} \tab is now \code{\link[dwapi]{download_file}}\cr
#'    \code{downloadFileAsDataFrame} \tab is now \code{\link[dwapi]{download_file_as_data_frame}}\cr
#'    \code{getDataset} \tab is now \code{\link[dwapi]{get_dataset}}\cr
#'    \code{patchDataset} \tab is now \code{\link[dwapi]{update_dataset}}\cr
#'    \code{replaceDataset} \tab is now \code{\link[dwapi]{replace_dataset}}\cr
#'    \code{syncDataset} \tab is now \code{\link[dwapi]{sync}}\cr
#'    \code{uploadDataFrame} \tab is now \code{\link[dwapi]{upload_data_frame}}\cr
#'    \code{uploadFile} \tab is now \code{\link[dwapi]{upload_file}}\cr
#'    \code{uploadFiles} \tab is now \code{\link[dwapi]{upload_files}}\cr
#'    \code{DatasetCreateRequest} \tab is now \code{\link[dwapi]{dataset_create_request}}\cr
#'    \code{DatasetPatchRequest} \tab is now \code{\link[dwapi]{dataset_update_request}}\cr
#'    \code{DatasetPutRequest} \tab is now \code{\link[dwapi]{dataset_replace_request}}\cr
#'    \code{FileBatchUpdateRequest} \tab is now \code{\link[dwapi]{file_batch_update_request}}\cr
#'    \code{FileCreateOrUpdateRequest} \tab is now \code{\link[dwapi]{file_create_or_update_request}}\cr
#' }
#' @seealso \link[dwapi]{dwapi}
NULL

addFile <- function(...) {
  .Defunct("dwapi::add_file", "data.world")
}
addFileBySource <- function(...) {
  .Defunct("dwapi::add_file_by_source", "data.world")
}
addFilesBySource <- function(...) {
  .Defunct("dwapi::add_files_by_source", "data.world")
}
createDataset <- function(...) {
  .Defunct("dwapi::create_dataset", "data.world")
}
deleteFileAndSyncSources <- function(...) {
  .Defunct("dwapi::delete_file", "data.world")
}
deleteFilesAndSyncSources <- function(...) {
  .Defunct("dwapi::delete_files", "data.world")
}
downloadFile <- function(...) {
  .Defunct("dwapi::download_file", "data.world")
}
downloadFileAsDataFrame <- function(...) {
  .Defunct("dwapi::download_file_as_data_frame", "data.world")
}
getDataset <- function(...) {
  .Defunct("dwapi::get_dataset", "data.world")
}
patchDataset <- function(...) {
  .Defunct("dwapi::update_dataset", "data.world")
}
replaceDataset <- function(...) {
  .Defunct("dwapi::replace_dataset", "data.world")
}
syncDataset <- function(...) {
  .Defunct("dwapi::sync", "data.world")
}
uploadDataFrame <- function(...) {
  .Defunct("dwapi::upload_data_frame", "data.world")
}
uploadFile <- function(...) {
  .Defunct("dwapi::upload_file", "data.world")
}
uploadFiles <- function(...) {
  .Defunct("dwapi::upload_files", "data.world")
}


DatasetCreateRequest <- function(...) {
  .Defunct("dwapi::dataset_create_request", "data.world")
}
DatasetPatchRequest <- function(...) {
  .Defunct("dwapi::dataset_update_request", "data.world")
}
DatasetPutRequest <- function(...) {
  .Defunct("dwapi::dataset_replace_request", "data.world")
}
FileBatchUpdateRequest <- function(...) {
  .Defunct("dwapi::file_batch_update_request", "data.world")
}
FileCreateOrUpdateRequest <- function(...) {
  .Defunct("dwapi::file_create_or_update_request", "data.world")
}
