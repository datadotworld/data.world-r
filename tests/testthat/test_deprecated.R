"data.world-r
Copyright 2017 data.world, Inc.

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

testthat::test_that("Legacy SQL query making correct calls", {
  sql_query <- "SELECT * FROM TableName LIMIT 10"
  query_params <- list(
    key1 = "value1",
    "?key2" = 1L,
    "?key3" = 1,
    "?key4" = TRUE,
    "?key5" = 1.5
  )
  dataset_key <- "ownerid/datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  testthat::with_mock(
    `data.world::set_config` = function(cfg) {
      testthat::expect_s3_class(cfg, "cfg")
      testthat::expect_equal(cfg$auth_token, "API_TOKEN")
    },
    `data.world::query.qry_sql` = function(qry, dataset) {
      testthat::expect_equal(qry$query, sql_query)
      testthat::expect_equal(qry$params, query_params)
      testthat::expect_equal(dataset, dataset_key)
      return(mock_response)
    },
    testthat::expect_warning({
      ret <- data.world::query(
        data.world(token = "API_TOKEN"),
        dataset = dataset_key,
        query = sql_query,
        queryParameters = query_params
      )
      testthat::expect_equal(ret, mock_response)
    })
  )
})

testthat::test_that("Legacy SPARQL query making correct calls", {
  sparql_query <- "SELECT * WHERE { ?s ?p ?o }"
  query_params <- list(
    key1 = "value1",
    "?key2" = 1L,
    "?key3" = 1,
    "?key4" = TRUE,
    "?key5" = 1.5
  )
  dataset_key <- "ownerid/datasetid"
  mock_response <- readr::read_csv("resources/sample.csv")
  testthat::with_mock(
    `data.world::set_config` = function(cfg) {
      testthat::expect_s3_class(cfg, "cfg")
      testthat::expect_equal(cfg$auth_token, "API_TOKEN")
    },
    `data.world::query.qry_sparql` = function(qry, dataset) {
      testthat::expect_equal(qry$query, sparql_query)
      testthat::expect_equal(qry$params, query_params)
      testthat::expect_equal(dataset, dataset_key)
      return(mock_response)
    },
    testthat::expect_warning({
      ret <- data.world::query(
        data.world(token = "API_TOKEN"),
        type = "sparql",
        dataset = dataset_key,
        query = sparql_query,
        queryParameters = query_params
      )
      testthat::expect_equal(ret, mock_response)
    })
  )
})
