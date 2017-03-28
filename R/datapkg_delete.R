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
datapkg_delete <- function(name, path = getwd()) {
  stopifnot(length(name) > 0)
  root <- sub("datapackage.json$", "", path)
  root <- sub("/$", "", root)
  json_path <- file.path(root, "datapackage.json")
  pkg_info <- jsonlite::fromJSON(json_path, simplifyVector = FALSE)
  resources <- pkg_info$resources
  deletedResource <- resources[unlist(lapply(resources, function (x) {x$name == name}))]
  if (length(deletedResource) == 1) {
    csv_path <- file.path(root, deletedResource[[1]]$path)
    stopifnot(file.exists(csv_path))

    # Remove the reference from datapackage.json
    pkg_info$resources <- resources[unlist(lapply(resources, function (x) {x$name != name}))]
    message(sprintf("Removing table %s from package %s", name, pkg_info$name))
    json <- jsonlite::toJSON(pkg_info, pretty = TRUE, auto_unbox = TRUE)
    writeLines(json, json_path)

    # Deleting the raw file
    message(sprintf("Deleting %s", csv_path))
    file.remove(csv_path)
  }

}
