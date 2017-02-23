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
successMessageResponse <- function() {
  return(successMessageResponseWithContent("resources/api.data.world/v0/SuccessMessage.sample.json", "application/json"))
}

#' @export
successMessageResponseWithContent <- function(pathToLocalContent, contentType, israw = FALSE) {
  content = charToRaw(readr::read_file(pathToLocalContent))
  return (structure(
    list(
      status_code = 200 ,
      content = content,
      headers = list("Content-Type", contentType)
    ),
    class = "response"
  ))
}

#' @export
cleanupTmpDir <- function() {
  unlink("tmp", recursive = TRUE, force = FALSE)
}

#' @export
createTmpDir <- function() {
  tmp_dir = "tmp"
  if (!dir.exists(tmp_dir)) {
    dir.create(tmp_dir, recursive = TRUE)
  }
}
