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

#' DatasetCreateRequest per https://api.data.world/v0/swagger.json
#' @param title Dataset name. 3 to 30 characters (required)
#' @param visibility PRIVATE or OPEN (required)
#' @param description Short description for dataset.
#' @param summary Dataset summary, markdown supported
#' @param tags Array of strings to tag datase
#' @param fileCreateRequests list of `FileCreateRequest`
#' @param licenseString Public Domain, PDDL, CC-0, CC-BY, ODC-BY, CC-BY-SA, ODC-ODbL, CC BY-NC-SA
#' @examples
#' request <- data.world::DatasetCreateRequest(title="coffeeCounty", visibility = "OPEN", description = "coffee county , AL - census income" , tags = c("rsdk", "sdk", "arr") , licenseString = "Public Domain")
#' request <- data.world::addFile(request = request, name = "file.csv", url = "http://data.world/file.csv")
#' @export
DatasetCreateRequest <- function(title, visibility , description = "", summary = "" , tags = list(), licenseString = "" , fileCreateRequests = list()) {
  if (title == '') {
    stop("title can't be empty")
  }

  if (visibility != "PRIVATE" & visibility != "OPEN") {
    stop("visibility have to be either PRIVATE or OPEN")
  }

  me <- list(
    title = title,
    visibility = visibility,
    description = description,
    summary = summary,
    tags = tags,
    license = licenseString,
    files = fileCreateRequests
  )
  class(me) <- "DatasetCreateRequest"
  return(me)
}
