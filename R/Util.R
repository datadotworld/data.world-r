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

#' Return the current data.world R-SDK version
#' @examples
#' data.world::sdkVersion()
#' @export
sdkVersion <- function() {
  is.nothing <- function(x) is.null(x)
  if (!is.nothing(utils::sessionInfo()$otherPkgs$data.world)) {
      ret <- utils::sessionInfo()$otherPkgs$data.world$Version
  } else {
    ret <- "X.X.X"
  }
  ret
}

#' Return the data.world sdk user-agent
#' @examples
#' data.world::userAgent()
#' @export
userAgent <- function() {
  ret <- sprintf("data.world-R - %s", data.world::sdkVersion())
  ret
}
