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

dw_test_that("SQL query making correct calls", {
  sql_query <- "SELECT * FROM TableName LIMIT 10"
  params <- list("value1", 1L, 1, TRUE, 1.5)
  dataset_key <- "ownerid/datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  ret <- testthat::with_mock(
    `dwapi::sql` = function(dataset, query, query_params) {
      testthat::expect_equal(dataset, dataset_key)
      testthat::expect_equal(query, sql_query)
      testthat::expect_equal(query_params, params)
      return(mock_response)
    },
        data.world::query(
          qry_sql(sql_query, params = params), dataset_key)
  )
  testthat::expect_equal(ret, mock_response)
})

dw_test_that("SPARQL query making correct calls", {
    sql_query <- "SELECT * WHERE { ?s ?p ?o }"
    params <- list(
      key1 = "value1",
      "?key2" = 1L,
      "?key3" = 1,
      "?key4" = TRUE,
      "?key5" = 1.5
    )
    dataset_key <- "ownerid/datasetid"
    mock_response <- readr::read_csv("resources/sample.csv")
    ret <- testthat::with_mock(
      `dwapi::sparql` = function(dataset, query, query_params) {
        testthat::expect_equal(dataset, dataset_key)
        testthat::expect_equal(query, sql_query)
        testthat::expect_equal(query_params, params)
        return(mock_response)
      },
          data.world::query(
            qry_sparql(sql_query, params = params), dataset_key)
    )
    testthat::expect_equal(ret, mock_response)
})
