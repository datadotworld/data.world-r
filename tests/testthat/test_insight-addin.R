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
  }
)

dw_test_that(
  "Project required", {
    expect_error(save_image_as_insight(title = "title", project_id = NULL),
                 regexp = "project_id.+cannot.+null")
  }
)

dw_test_that(
  "Project format", {
    expect_error(save_image_as_insight(title = "title",
                                       project_id = "myproject"),
                 regexp = "project_id.+invalid")
  }
)

dw_test_that(
  "Projects filtered", {
    test_project_list <- list(
      list("accessLevel" = "ADMIN", "id" = "o/p1"),
      list("accessLevel" = "WRITE", "id" = "o/p2"),
      list("accessLevel" = "READ", "id" = "o/p3"),
      list("accessLevel" = "NONE", "id" = "o/p4")
    )
    filtered_project_list <- insight_project_filter(test_project_list)
    expect_equal(2, length(filtered_project_list))
    expect_equal(0, length(setdiff(
      c("o/p1", "o/p2"),
      sapply(filtered_project_list, function(p) p$id)
    )))
  }
)
