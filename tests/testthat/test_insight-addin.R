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

dw_test_that(
  "Title required", {
    expect_error(save_image_as_insight(title = NULL, project_id = "oid/pid"),
                 regexp = "title.+cannot.+null")
})

dw_test_that(
  "Project required", {
    expect_error(save_image_as_insight(title = "title", project_id = NULL),
                 regexp = "project_id.+cannot.+null")
  })

dw_test_that(
  "Project format", {
    expect_error(save_image_as_insight(title = "title",
                                       project_id = "myproject"),
                 regexp = "project_id.+invalid")
  })
