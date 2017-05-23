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

#' Set up default options
#' @keywords internal
.onLoad <- function(...) {
  op <- options()
  op.dw <-
    list(dw.config_path = path.expand(file.path("~", ".dw", "config")))

  toset <- !(names(op.dw) %in% names(op))
  if (any(toset))
    options(op.dw[toset])

  invisible()
}

#' Apply configuration from file or envvars and load dwapi
#' @keywords internal
.onAttach <- function(...) {
  # Load dwapi as a result of data.world being attached
  if (!is_attached("dwapi")) {
    lapply(c("dwapi"), library, character.only = TRUE, warn.conflicts = FALSE)
  }

  profile <- Sys.getenv("DW_PROFILE", unset = NA)
  if (is.na(profile)) {
    profile <- "DEFAULT"
  }

  suppressWarnings(
    data.world::set_config(
      data.world::cfg_saved(profile = profile)))

  data.world::set_config(data.world::cfg_env())

  invisible()
}

#' Determine if library is already attached
#' @keywords internal
is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
