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

#' Apply configuration to current R session.
#'
#' @param cfg Configuration object.
#' @examples
#' data.world::set_config(data.world::cfg_saved())
#' data.world::set_config(data.world::cfg_env())
#' data.world::set_config(data.world::cfg("YOUR_TOKEN"))
#' @export
set_config <- function(cfg) {
  UseMethod("set_config")
}

#' @describeIn set_config Apply configuration using runtime values.
#'
#' @seealso \code{\link{cfg}}
#' @export
set_config.default <- function(cfg) {
  if (!is.null(cfg$auth_token)) {
    options(dw.auth_token = cfg$auth_token)
    dwapi::configure(auth_token = cfg$auth_token)
  }
  invisible()
}

#' @describeIn set_config Apply configuration using environment variables.
#'
#' @seealso \code{\link{cfg_env}}
#' @export
set_config.cfg_env <- function(cfg) {
  # delegate to default method
  token_var <- Sys.getenv(cfg$auth_token_var, unset = NA)
  if (!is.na(token_var)) {
    data.world::set_config(cfg(auth_token = token_var))
  }
  invisible()
}

#' @describeIn set_config Apply configuration using file-based configuration.
#'
#' @seealso \code{\link{cfg_saved}}
#' @export
set_config.cfg_saved <- function(cfg) {
  config_path <- getOption("dw.config_path")
  if (file.exists(config_path)) {
    config <- ini::read.ini(filepath = config_path)
  } else {
    warning("Configuration file not found at ", config_path)
    return()
  }

  profile <- config[[cfg$profile]]
  if (!is.null(profile)) {
    # delegate to default method
    set_config(cfg(auth_token = profile$auth_token))
  } else {
    warning(
      "Configuration profile \"", cfg$profile,
      "\" not found in ", config_path)
  }

  invisible()
}

#' Construct configuration object using runtime values.
#'
#' @param auth_token API authorization token.
#' @return Object of type \code{cfg}
#' @examples
#' runtime_cfg <- data.world::cfg(auth_token = "YOUR_TOKEN")
#' data.world::set_config(runtime_cfg)
#' @export
cfg <- function(auth_token) {
  me <- list(auth_token = auth_token)
  class(me) <- "cfg"
  return(me)
}

#' Construct configuration object using environment variables.
#'
#' @param auth_token_var Name of environment variable for API authorization
#' token (default: \code{DW_AUTH_TOKEN}).
#' @return Object of type \code{cfg_env}
#' @examples
#' envvars_cfg <- data.world::cfg_env()
#' data.world::set_config(envvars_cfg)
#' @export
cfg_env <- function(auth_token_var = "DW_AUTH_TOKEN") {
  me <- list(auth_token_var = auth_token_var)
  class(me) <- "cfg_env"
  return(me)
}

#' Construct configuration object using file-based configuration.
#'
#' @param profile Name of configuration profile (default: \code{DEFAULT}).
#' @return Object of type \code{cfg_saved}
#' @examples
#' saved_cfg <- data.world::cfg_saved()
#' data.world::set_config(saved_cfg)
#' @export
cfg_saved <- function(profile = "DEFAULT") {
  me <- list(profile = profile)
  class(me) <- "cfg_saved"
  return(me)
}

#' Save configuration to file in the user's home directory.
#'
#' @param auth_token API authorization token.
#' @param ... Reserved for future configuration parameters.
#' @param profile Configuration profile.
#' @return Object of type \code{\link{cfg_saved}}
#' @examples
#' \dontrun{
#'   saved_cfg <- data.world::save_config(auth_token = "YOUR_TOKEN")
#'   data.world::set_config(saved_cfg)
#' }
#' @export
save_config <-
  function(auth_token,
    ...,
    profile = "DEFAULT") {

    config_path <- getOption("dw.config_path")
    if (file.exists(config_path)) {
      config <- ini::read.ini(filepath = config_path)
      if (is.null(config[[profile]])) {
        config[[profile]] <- list()
      }
      config[[profile]]$auth_token <- auth_token
    } else {
      if (!dir.exists(dirname(config_path))) {
        dir.create(dirname(config_path), recursive = TRUE)
      }
      config <- list()
      config[[profile]] <- list(auth_token = auth_token)
    }

    ini::write.ini(config, filepath = config_path)
    return(data.world::cfg_saved(profile))
  }
