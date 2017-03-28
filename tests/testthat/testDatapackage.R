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

library("data.world")
library("testthat")
source("testUtil.R")


mockDownloadCall <- function () {
  mockResponseLocalContentPath = "resources/datapackage.zip"
  dataset = "jonloyens/an-intro-to-dataworld-dataset"
  response <- with_mock(
    `httr::GET` = function(url, header , progress, userAgent)  {
      expect_equal(
        url,
        sprintf("https://download.data.world/datapackage/%s", dataset)
      )
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(userAgent$options$useragent, data.world::userAgent())
      return(
        successMessageResponseWithContent(mockResponseLocalContentPath, "application/zip")
      )
    },
    `mime::guess_type` = function(...) NULL,
    data.world::downloadDatapackage(
      data.world(token = "API_TOKEN"),
      dataset = dataset
    )
  )
  return(response)
}

test_that("test datapackage construct" , {
  createTmpDir()
  tryCatch ({
    mockResponseLocalContentPath = "resources/datapackage.zip"
    dataset = "jonloyens/an-intro-to-dataworld-dataset"
    response <- mockDownloadCall()
    testthat::expect_s3_class(response, "DataPackage")
    tables <- data.world::listTables(response)
    testthat::expect_length(tables, 3)
    testthat::expect_true('changelog' %in% tables)
    testthat::expect_true('datadotworldbballstats' %in% tables)
    testthat::expect_true('datadotworldbballteam' %in% tables)
    changeLogTable <- data.world::loadTable(response, table = 'changelog')
    testthat::expect_true(is.data.frame(changeLogTable))
    testthat::expect_length(changeLogTable, 2)
    testthat::expect_length(changeLogTable$Change, 5)
    testthat::expect_length(changeLogTable$Date, 5)
    clSchema <- data.world::loadSchema(response, table = 'changelog')
    testthat::expect_equal(as.character(clSchema[clSchema$name == 'Date', 'rtype']) , 'date')
    testthat::expect_equal(as.character(clSchema[clSchema$name == 'Change', 'rtype']) , 'character')
    response <- data.world::addTable(response, iris, "iris")
    tables <- data.world::listTables(response)
    testthat::expect_length(tables, 4)
    testthat::expect_true('changelog' %in% tables)
    testthat::expect_true('datadotworldbballstats' %in% tables)
    testthat::expect_true('datadotworldbballteam' %in% tables)
    testthat::expect_true('iris' %in% tables)
    responseNew <- mockDownloadCall()
    diff <- data.world::diffDatapackage(response, responseNew)
    print(diff$missing)
    expect_true("iris" %in% diff$missing)
    diff <- data.world::diffDatapackage(responseNew, response)
    expect_true("iris" %in% diff$unexpected)
  }, finally = {
    cleanupTmpDir()
  })
})


