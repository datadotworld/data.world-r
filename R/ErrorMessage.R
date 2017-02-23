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

#' De-serialize a structured list into ErrorMessage object
#' @param structure structured response
#'
#' @export
ErrorMessage <- function(structure) {
  me <- list(
    # non-required
    code = structure$code,
    message = structure$message,
    details = structure$details
  )
  class(me) <- "ErrorMessage"
  return(me)
}
