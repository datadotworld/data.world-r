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

#' DatasetSummaryResponse per https://api.data.world/v0/swagger.json
#' @param structure the structured response
#' @seealso \code{\link{getDataset}}
#' @export
DatasetSummaryResponse <- function(structure) {
  me <- list(
    # required
    owner = structure$owner,
    id = structure$id,
    title = structure$title,
    visibility = structure$visibility,
    updated = structure$updated,
    created = structure$created,
    status = structure$status,
    # non-required
    description = structure$description,
    summary = structure$summary,
    tags = structure$tags,
    license = structure$license,
    files = list()
  )
  if (length(structure$files) > 0) {
    for (i in 1:length(structure$files)) {
      me$files[[i]] <- data.world::FileSummaryResponse(structure$files[[i]])
    }
  }
  class(me) <- "DatasetSummaryResponse"
  return(checkDatasetSummaryResponse(me))
}

checkDatasetSummaryResponse <- function(object) {
  ret <- object
  if (is.null(object$created) | is.null(object$id) | is.null(object$owner) | is.null(object$status) | is.null(object$title)
      | is.null(object$updated) | is.null(object$visibility)) {
    stop("invalid DatasetSummaryResponse object")
  }
  ret
}
