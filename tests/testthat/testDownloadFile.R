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

test_that("downloadFile making the correct HTTR request" , {
  createTmpDir()

  tryCatch ({
    mockResponseLocalContentPath = "resources/file1.csv"
    dataset = "ownerid/datasetid"
    tmpOutput = "tmp/file1.csv"
    response <- with_mock(
      `httr::GET` = function(url, header , progress, userAgent)  {
        expect_equal(
          url,
          sprintf(
            "https://download.data.world/file_download/ownerid/datasetid/file1.csv",
            dataset
          )
        )
        expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
        expect_equal(userAgent$options$useragent, data.world::userAgent())
        return(
          successMessageResponseWithContent(mockResponseLocalContentPath, "application/csv")
        )
      },
      `mime::guess_type` = function(...)
        NULL,
      data.world::downloadFile(
        data.world(token = "API_TOKEN"),
        dataset = dataset,
        fileName = "file1.csv",
        output = tmpOutput
      )
    )
    expect = as.data.frame(readr::read_csv(mockResponseLocalContentPath))
    actual = as.data.frame(readr::read_csv(tmpOutput))
    expect_equal(all(expect == actual), TRUE)
  }, finally = {
    cleanupTmpDir()
  })
})
