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

test_that("test datatypes util", {
  types <- data.world::datatypes()
  testthat::expect_true(nrow(types) > 0)
  testthat::expect_equal(as.character(types[types$r == 'logical' , 'sparql' ]), 'http://www.w3.org/2001/XMLSchema#boolean')
  testthat::expect_equal(as.character(types[types$datapackage == 'boolean' , 'sparql' ]), 'http://www.w3.org/2001/XMLSchema#boolean')
  testthat::expect_equal(as.character(types[types$sparql == 'http://www.w3.org/2001/XMLSchema#boolean' , 'r' ]), 'logical')
})

test_that("test cross platform type lookup", {
  boolDataType <- data.world::datatypes(r="logical")
  testthat::expect_equal(as.character(boolDataType$sparql), 'http://www.w3.org/2001/XMLSchema#boolean')
  testthat::expect_equal(as.character(boolDataType$datapackage), 'boolean')
  boolDataType <- data.world::datatypes(r="logical" , datapackage='boolean')
  testthat::expect_equal(as.character(boolDataType$sparql), 'http://www.w3.org/2001/XMLSchema#boolean')
  boolDataType <- data.world::datatypes(r="logical" , datapackage='bool')
  testthat::expect_equal(nrow(boolDataType), 0)
})

