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

#' Download the input file into an R data frame
#' @param connection the connection to data.world
#' @param dataset the "agentid/datasetid" for the dataset against which to execute the query
#' @param fileName the filename as listed in the data.world dataset
#'   (only csv file is supported for now)
#' @export
downloadFileAsDataFrame <- function(connection, dataset, fileName) {
  UseMethod("downloadFileAsDataFrame")
}

#' @export
downloadFileAsDataFrame.default <- function(connection, dataset, fileName) {
  print("nope.")
}

#' @export
downloadFileAsDataFrame.data.world <- function(connection, dataset, fileName) {
  if (!endsWith(fileName, ".csv")) {
    stop("only support csv extension files.")
  }

  tmp_dir = sprintf("%s/tmp/%s", getwd(), dataset)
  if (!dir.exists(tmp_dir)) {
    dir.create(tmp_dir, recursive = TRUE)
  }
  tmp_path = sprintf("%s/%s", tmp_dir, fileName)
  download_status <- data.world::downloadFile(connection, dataset, fileName, tmp_path)
  if (download_status$category == "Success") {
    ret <- utils::read.csv(file=tmp_path, header=TRUE)
    ret
  } else {
    stop(sprintf("failed to download %s/%s", dataset, fileName))
  }
}
