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

#' data.world: The main R package for working with data.world datasets.
#'
#' The data.world package makes it easy to access and work with
#' data.world's datasets.
#'
#' @section Configuration:
#'
#' The package can be configured with the \code{\link{set_config}} function.
#'
#' @section Query features:
#'
#' Use \code{\link{query}} to run SPARQL and SQL queries.
#' Use \code{\link{qry_sql}} and \code{\link{qry_sparql}} to construct
#' query objects and to pass parameters to queries.
#'
#' @section Add-ins:
#'
#' Use the included "New insight" add-in to publish plots as
#' project insights from R Studio.
#'
#' @section REST API:
#'
#' data.world's REST APIs can be accessed via the \code{dwapi} package.
#' \code{dwapi} is bundled and automatically loaded with \code{data.world}.
#' See \code{\link{dwapi}} for additional information.
#'
#' @docType package
#' @name data.world
NULL
