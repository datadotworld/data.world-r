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
configure <- function(token = NULL,
                      userid = NULL,
                      profileName = "default",
                      propsfile = sprintf("%s/.data.world", path.expand('~')),
                      baseDWApiUrl = "http://localhost:9104/",
                      baseQueryApiUrl = "http://localhost:9094/",
                      baseDownloadApiUrl = "http://localhost:9094",
                      baseDWConfigPath = "~/.dw",
                      ...
) {
  configPath <- sprintf("%s/config", baseDWConfigPath)
  if (file.exists(configPath)) {
    DW_PROFILES <<- ini::read.ini(configPath)
  }
  is.nothing <- function(x) is.null(x) || is.na(x) || is.nan(x)
  if (is.nothing(token)) {
    message(sprintf("configuring access for profile %s", profileName))
    # userid <- readline(prompt = "Enter the data.world user name associated with this token: ")
    token <- readline(prompt = "Enter a data.world token (can be found at https://data.world/settings/advanced): ")
  }
  if (!exists("DW_PROFILES")) {
    DW_PROFILES <<- list()
  }
  DW_PROFILES[[profileName]] <<- list(token = token,
                                      # userid = userid,
                                      baseDWApiUrl = baseDWApiUrl,
                                      baseQueryApiUrl = baseQueryApiUrl,
                                      baseDownloadApiUrl = baseDownloadApiUrl)
  if (!dir.exists(baseDWConfigPath)) {
    dir.create(baseDWConfigPath)
  }
  ini::write.ini(DW_PROFILES , configPath)
}

#' @export
assertConfig <- function(baseDWConfigPath = "~/.dw") {
  if (!exists("DW_PROFILES")) {
    configPath <- sprintf("%s/config", baseDWConfigPath)
    if (file.exists(configPath)) {
      DW_PROFILES <<- ini::read.ini(configPath)
    } else {
      stop(sprintf("%s does not exist. Please run data.world::configure() to configure your data.world client first", configPath))
    }
  }
}
