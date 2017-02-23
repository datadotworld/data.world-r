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

test_that("uploadDataFrame making the correct HTTR request" , {
  tryCatch ({
    df = data.frame(a = c(1, 2, 3), b = c(4, 5, 6))
    response <- with_mock(
      `httr::PUT` = function(url , body, header , progress, userAgent)  {
        expect_equal(url,
                     "https://api.data.world/v0/uploads/ownerid/datasetid/files/df.csv")
        expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
        expect_equal(header$headers[["Content-Type"]], "application/octet-stream")
        expect_equal(class(body), "form_file")
        actual <- as.data.frame(readr::read_csv(body$path))
        expect_equal(all(df == actual), TRUE)
        expect_equal(userAgent$options$useragent, data.world::userAgent())
        return(successMessageResponse())
      },
      `mime::guess_type` = function(...)
        NULL,
      data.world::uploadDataFrame(
        data.world(token = "API_TOKEN"),
        fileName = "df.csv",
        dataFrame = df,
        dataset = "ownerid/datasetid"
      )
    )
    expect_equal(class(response), "SuccessMessage")
  }
  , finally = {
    cleanupTmpDir()
  })
})
