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
#' Upload a dataframe to a data.world dataset as csv
#' @param connection the connection to data.world
#' @param dataFrame the data frame need to be uploaded
#' @param fileName the filename (with extension) to be view in the dataset
#' @param dataset the data.world datasetid
#' @examples
#' conn <- data.world(token = "YOUR_API_TOKEN_HERE")
#' df = data.frame(a = c(1,2,3),b = c(4,5,6))
#' uploadDataFrame(connection = conn, fileName="sample.csv",
#' dataFrame = df, dataset = "ownerid/datasetid")
#' @export
uploadDataFrame <- function(connection, dataFrame, fileName, dataset) {
  UseMethod("uploadDataFrame")
}

#' @export
uploadDataFrame.default <- function(connection, dataFrame, fileName, dataset) {
  print("nope.")
}

#' @export
uploadDataFrame.data.world <- function(connection, dataFrame, fileName, dataset) {
  if (!is.data.frame(dataFrame)) {
    stop("input is not a data frame")
  }
  tmp_dir = sprintf("%s/tmp/%s", getwd(), dataset)
  if (!dir.exists(tmp_dir)) {
    dir.create(tmp_dir, recursive = TRUE)
  }
  tmp_path = sprintf("%s/%s", tmp_dir, fileName)
  message(sprintf("tmp file %s created.", tmp_path))
  utils::write.csv(dataFrame, file = tmp_path, fileEncoding = "UTF-8", na = "", row.names = FALSE)
  ret <- data.world::uploadFile(connection, tmp_path, fileName, dataset)
  ret
}
