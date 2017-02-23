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

test_that("deleteFilesAndSyncSources making the correct HTTR request" , {
  response <- with_mock(
    `httr::DELETE` = function(url, header, userAgent)  {
      expect_equal(url,
                   "https://api.data.world/v0/datasets/ownerid/datasetid/files?name=file1.csv&name=file2.csv")
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(userAgent$options$useragent, data.world::userAgent())
      return(successMessageResponse())
    },
    `mime::guess_type` = function(...)
      NULL,
    data.world::deleteFilesAndSyncSources(data.world(token = "API_TOKEN"), dataset = "ownerid/datasetid", names = list("file1.csv", "file2.csv"))
  )
  expect_equal(class(response), "SuccessMessage")
})

test_that("deleteFileAndSyncSources making the correct HTTR request" , {
  response <- with_mock(
    `httr::DELETE` = function(url, header, userAgent)  {
      expect_equal(url,
                   "https://api.data.world/v0/datasets/ownerid/datasetid/files/file.csv")
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(userAgent$options$useragent, data.world::userAgent())
      return(successMessageResponse())
    },
    `mime::guess_type` = function(...)
      NULL,
    data.world::deleteFileAndSyncSources(data.world(token = "API_TOKEN"), dataset = "ownerid/datasetid", name = "file.csv")
  )
  expect_equal(class(response), "SuccessMessage")
})
