"data.world-r
Copyright 2018 data.world, Inc.

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
  },
    add = TRUE)

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
  },
    add = TRUE)

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

dw_test_that <- function(...) {
  auth_token_bkp <- getOption("dwapi.auth_token")
  on.exit({
    options(dwapi.auth_token = auth_token_bkp)
  })

  options(dwapi.auth_token = "API_TOKEN")

  create_tmp_dir() #nolint
  tryCatch({
    return(testthat::test_that(...))
  },
  finally = {
    cleanup_tmp_dir() #nolint
  })
}

cleanup_tmp_dir <- function() {
  unlink(tempdir(), recursive = TRUE, force = FALSE)
}

create_tmp_dir <- function() {
  tmp_dir <- tempdir()
  if (!dir.exists(tmp_dir)) {
    dir.create(tmp_dir, recursive = TRUE)
  }
  return(tmp_dir)
}
