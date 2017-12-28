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
    project$id
  }
  )
  names(project_choice_list) <- sapply(
    USE.NAMES = FALSE, project_list, function(project) {
    project$title
  }
  )

  ui <- miniUI::miniPage(

    shiny::tags$head(shiny::tags$style(
      type = "text/css",
      "img {max-width: 100%; width: 100%; height: auto}"
    )),

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

    #shiny::observe({
    #})



    shiny::observeEvent(input$done, {
      if (current_plot_exists()) {
        save_insight(input$project, input$title, input$description)
      } else {
        writeLines("Nothing to do...no current plot")
      }
      shiny::stopApp()
    })

    output$thumb <- renderImage(deleteFile = TRUE, {

      tf <- tempfile(fileext = ".png")

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

  # We'll use a pane viwer, and set the minimum height at
  # 300px to ensure we get enough screen space to display the clock.
  viewer <- shiny::paneViewer(300)
  shiny::runGadget(ui, server, viewer = viewer)

}

current_plot_exists <- function() {
  "RStudioGD" %in% names(dev.list())
}

save_insight <- function(project_id, title, description) {
  # todo: actually call the dwapi
  writeLines(paste0("Submitting insight for project=", project_id,
                    ", description=", description, ", title=", title))
}
