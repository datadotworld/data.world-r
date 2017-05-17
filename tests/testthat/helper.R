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

#' Set up envvars for tests then restore original R landscape after tests run.
#'
#' @param ... Named arguments are set as variables. Unnamed are run as tests.
#' @keywords internal
with_envvars <- function(..., .env = parent.frame()) {
  envs <- Sys.getenv(names = TRUE)
  on.exit({
    do.call(Sys.setenv, as.list(envs))
  }, add = TRUE)

  args <- eval(substitute(alist(...)))
  tmp_vars <- (names(args) != "")
  if (any(tmp_vars)) {
    tests <- args[!tmp_vars]
    do.call(Sys.setenv,
      lapply(args[tmp_vars], function(x) {
        eval(x, parent.frame())
      }))
  } else {
    tests <- args
  }

  for (test in tests) {
    eval(test, .env)
  }
}

#' Set up options for tests then restore original R landscape after tests run.
#'
#' @param ... Named arguments are set as options. Unnamed are run as tests.
#' @keywords internal
with_options <- function(..., .env = parent.frame()) {
  opts <- options()
  on.exit({
    options(opts)
  }, add = TRUE)

  args <- eval(substitute(alist(...)))
  tmp_opts <- (names(args) != "")
  if (any(tmp_opts)) {
    options(lapply(args[tmp_opts], function(x) {
      eval(x, .env)
    }))
    tests <- args[!tmp_opts]
  } else {
    tests <- args
  }
  for (test in tests) {
    eval(test, .env)
  }
}

#' Set up tempdir for tests then delete it after tests run
#'
#' @param ... Tests to run.
#' @keywords internal
with_tmpdir <- function(..., .env = parent.frame()) {
  on.exit({
    unlink(tempdir(), recursive = TRUE, force = FALSE)
  }, add = TRUE)

  tmp_dir <- tempdir()
  if (!dir.exists(tmp_dir)) {
    dir.create(tmp_dir, recursive = TRUE)
  }

  tests <- eval(substitute(alist(...)))
  for (test in tests) {
    eval(test, .env)
  }
}
