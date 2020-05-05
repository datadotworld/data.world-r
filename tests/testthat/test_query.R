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
  expected_query <- "SELECT * FROM TableName LIMIT 10"
  expected_query_params <- list("value1", 1L, 1, TRUE, 1.5)
  expected_owner_id <- "ownerid"
  expected_dataset_id <- "datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  ret <- testthat::with_mock(
    `dwapi::sql` = function(owner_id, dataset_id, query, query_params) {
      testthat::expect_equal(owner_id, expected_owner_id)
      testthat::expect_equal(dataset_id, expected_dataset_id)
      testthat::expect_equal(query, expected_query)
      testthat::expect_equal(query_params, expected_query_params)
      return(mock_response)
    },
    data.world::query(
      qry_sql(expected_query, params = expected_query_params),
      expected_owner_id, expected_dataset_id)
  )
  testthat::expect_equal(ret, mock_response)
})

dw_test_that("SQL query with combined dataset reference", {
  expected_query <- "SELECT * FROM TableName LIMIT 10"
  expected_query_params <- list("value1", 1L, 1, TRUE, 1.5)
  expected_dataset_ref <- "ownerid/datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  ret <- testthat::with_mock(
    `dwapi::sql` = function(owner_id, dataset_id, query, query_params) {
      testthat::expect_equal(owner_id, "ownerid")
      testthat::expect_equal(dataset_id, "datasetid")
      testthat::expect_equal(query, expected_query)
      testthat::expect_equal(query_params, expected_query_params)
      return(mock_response)
    },
    data.world::query(
      qry_sql(expected_query, params = expected_query_params),
      expected_dataset_ref)
  )
  testthat::expect_equal(ret, mock_response)
})

dw_test_that("SQL query with URL dataset reference", {
  expected_query <- "SELECT * FROM TableName LIMIT 10"
  expected_query_params <- list("value1", 1L, 1, TRUE, 1.5)
  expected_dataset_ref <- "https://data.world/ownerid/datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  ret <- testthat::with_mock(
    `dwapi::sql` = function(owner_id, dataset_id, query, query_params) {
      testthat::expect_equal(owner_id, "ownerid")
      testthat::expect_equal(dataset_id, "datasetid")
      testthat::expect_equal(query, expected_query)
      testthat::expect_equal(query_params, expected_query_params)
      return(mock_response)
    },
    data.world::query(
      qry_sql(expected_query, params = expected_query_params),
      expected_dataset_ref)
  )
  testthat::expect_equal(ret, mock_response)
})

dw_test_that("SPARQL query making correct calls", {
  expected_query <- "SELECT * WHERE { ?s ?p ?o }"
  expected_query_params <- list(
    key1 = "value1",
    "?key2" = 1L,
    "?key3" = 1,
    "?key4" = TRUE,
    "?key5" = 1.5
  )
  expected_owner_id <- "ownerid"
  expected_dataset_id <- "datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  ret <- testthat::with_mock(
    `dwapi::sparql` = function(owner_id, dataset_id, query, query_params) {
      testthat::expect_equal(owner_id, expected_owner_id)
      testthat::expect_equal(dataset_id, expected_dataset_id)
      testthat::expect_equal(query, expected_query)
      testthat::expect_equal(query_params, expected_query_params)
      return(mock_response)
    },
    data.world::query(
      qry_sparql(expected_query, params = expected_query_params),
      expected_owner_id, expected_dataset_id)
  )
  testthat::expect_equal(ret, mock_response)
})
