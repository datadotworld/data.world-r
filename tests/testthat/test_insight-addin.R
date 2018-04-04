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

dw_test_that(
  "Graceful handling of user with no projects", {
    test_project_list <- list()
    filtered_project_list <- insight_project_filter(test_project_list)
    expect_equal(0, length(filtered_project_list))
  }
)

dw_test_that(
  "Insight saved", {
    response <- with_mock(
      `dwapi::upload_file` = function(project_id, image_file, fn) {
        ret <- list()
        ret$message <- "File uploaded"
        class(ret) <- "success_message"
        ret
      },
      `dwapi::create_insight` = function(
        project_owner, project_id, create_insight_req) {
        ret <- list()
        ret$message <- "Insight created successfully."
        ret$uri <- "https://data.world/test"
        class(ret) <- "create_insight_response"
        ret
      },
      save_image_as_insight("ownerid/projectid", "title",
                            image_file = tempfile())
    )
    expect_equal(2, length(response))
    expected_names <- c("upload_result", "insight_result")
    expect_equal(0, length(setdiff(expected_names, names(response))))
    expect_equal(0, length(setdiff(y = expected_names, names(response))))
  }
)
