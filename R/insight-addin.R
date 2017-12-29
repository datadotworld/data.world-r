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

#' Driver function for data.world Insight Add-in
#' @keywords internal
add_insight_addin <- function() {

  api_token <- getOption("dwapi.auth_token")

  if (is.null(api_token)) {
    #nolint start
    stop(paste0("API authentication must be configured. ",
                "To configure, use data.world::set_config(save_config(auth_token = \"YOUR API TOKEN\")) or ",
                "dwapi::configure()"))
    #nolint end
  }

  project_filter_function <- function(project) {
    ret <- NULL
    if (project[["accessLevel"]] %in% c("ADMIN", "WRITE")) {
      ret <- project
    }
    ret
  }

  project_list <- lapply(c(dwapi::get_projects_user_contributing()$records,
                           dwapi::get_projects_user_own()$records),
                         project_filter_function)

  project_list <- project_list[sapply(project_list, function(item) {
    !is.null(item)
  })]

  project_choice_list <- sapply(
    USE.NAMES = FALSE, project_list, function(project) {
    paste0(project$owner, "/", project$id)
  }
  )
  names(project_choice_list) <- sapply(
    USE.NAMES = FALSE, project_list, function(project) {
    project$title
  }
  )

  ui <- miniUI::miniPage(

    shiny::tags$head(
      shiny::tags$style(
        type = "text/css",
        "img {max-width: 100%; width: 100%; height: auto}"
      ),
      shiny::tags$link(
        rel = "stylesheet", type = "text/css",
        href = "http://fonts.googleapis.com/css?family=Lato:300,300i,400,400i,700,700i") # nolint
    ),

    shiny::includeCSS(system.file("dw-bootstrap.css", package="data.world")),

    miniUI::gadgetTitleBar("Add Insight to data.world"),
    miniUI::miniContentPanel(
      shiny::fillRow(
        shiny::imageOutput("thumb", height = NULL, width = "90%"),
        shiny::column(12,
                      shiny::selectInput("project", "Project:",
                                         choices = project_choice_list),
                      shiny::textInput("title", "Title:"),
                      shiny::textAreaInput("description", "Description:")
        )
      )
    )
  )

  server <- function(input, output, session) {

    shiny::observeEvent(input$done, {
      if (current_plot_exists()) {
        save_image_as_insight(input$project, input$title, input$description,
                     session$userData$f) # nolint
      } else {
        writeLines("Nothing to do...no current plot")
      }
      shiny::stopApp()
    })

    output$thumb <- shiny::renderImage(deleteFile = FALSE, {

      tf <- tempfile(fileext = ".png")
      session$userData$f <- tf # nolint

      if (current_plot_exists()) {
        dev.copy(png, filename = tf, height = 300, width = 300)
        dev.off()
      } else {
        png(filename = tf, height = 300, width = 300)
        plot.new()
        mtext("No current plot available")
        dev.off()
      }

      list(src = tf, alt = "Plot thumb")

    })

  }

  viewer <- shiny::dialogViewer("Add data.world Insight", height = 400)
  shiny::runGadget(ui, server, viewer = viewer)

}

#' Determine if there is a plot in the RStudio Plots view
#' @return true if a plot exists
#' @keywords internal
current_plot_exists <- function() {
  "RStudioGD" %in% names(dev.list())
}

#' Save an image file as a data.world insight
#' @param project_id the fully-qualified id of the project to house the insight
#' @param title the title of the insight
#' @param description the description of the insight (optional)
#' @param image_file the file path containing the image
#' @return a list containing the values returned by the upload_file and
#' create_insight dwapi functions
#' @keywords internal
save_image_as_insight <- function(project_id, title, description, image_file) {

  fn <- paste0(title, ".png")

  upload_result <- dwapi::upload_file(project_id, image_file, fn)

  unlink(image_file)

  project_parts <- unlist(stringi::stri_split(project_id, regex = "/"))

  image_url <- paste0("https://data.world/api/",
                      project_parts[1],
                      "/", "dataset", "/",
                      project_parts[2],
                      "/", "file", "/", "raw", "/",
                      URLencode(fn))

  insight_result <- dwapi::create_insight(
    project_parts[1], project_parts[2],
    dwapi::insight_create_request(title, description, image_url))

  ret <- list(upload_result = upload_result, insight_result = insight_result)

  writeLines(paste0(
    "Successfully created insight ", title, " within project ",
    project_id
  ))

  ret

}
