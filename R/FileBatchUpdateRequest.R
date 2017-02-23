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

#' FileBatchUpdateRequest per https://api.data.world/v0/swagger.json
#' @param fileSources list of files
#' request <- data.world::FileBatchUpdateRequest()
#' request <- data.world::FileBatchUpdateRequest(list(data.world::FileCreateOrUpdateRequest(name, url)))
#' request <- data.world::addFile(request = request, name = "file.csv", url = "http://data.world/file.csv")
#' @export
FileBatchUpdateRequest <- function(fileSources = list()) {
  if (!is.list(fileSources)) {
    stop("fileSources must be an array")
  }
  me <- list(
    "files" = fileSources
  )
  class(me) <- "FileBatchUpdateRequest"
  return(me)
}
