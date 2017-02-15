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
#' De-serialize a structured list into FileSummaryResponse object
#' @param structure structured response
#' @export
FileSummaryResponse <- function(structure) {
  me <- list(
    # required
    created = structure$created,
    name = structure$name,
    updated = structure$updated,
    # non-required
    sizeInBytes = structure$sizeInBytes,
    source = data.world::FileSourceSummaryResponse(structure$source)
  )
  class(me) <- "FileSummaryResponse"
  return(checkFileSummaryResponse(me))
}

checkFileSummaryResponse <- function(object) {
  ret <- object
  if (is.null(object$created) | is.null(object$name) | is.null(object$updated)) {
    stop("invalid FileSummaryResponse object")
  }
  ret
}
