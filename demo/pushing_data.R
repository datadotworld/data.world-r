library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()
default_variables = set_default_demo_variables()


create_dataset <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)

  # Construct the create dataset request
  request <- data.world::DatasetCreateRequest(
    title = dataset_title,
    visibility = "PRIVATE",
    description = "demo dataset created by data.world r-sdk " ,
    tags = c("rsdk", "sdk", "demo") ,
    licenseString = "Public Domain"
  )
  readline(sprintf("press any key to create dataset %s", dataset_url))
  # Create the dataset
  response <- data.world::createDataset(
    connection = data.world(),
    createDatasetRequest = request,
    ownerId = dataset_owner
  )
  message(response)
  message(sprintf("a demo dataset has been created %s", dataset_url))
}

create_dataset(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)

# Add File by Source

add_file_by_source <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  readline(sprintf("press any key to add file to dataset %s", dataset_url))
  response <- data.world::addFileBySource(connection = data.world(),
                                          dataset = sprintf("%s/%s", dataset_owner, dataset_title),
                                          name = "demo7.csv",
                                          url = "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")
  message(response)
}


add_file_by_source(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)

# Sync Dataset

sync <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  readline(sprintf("press any key to sync dataset %s", dataset_url))
  response <- data.world::sync(connection = data.world(), dataset=sprintf("%s/%s", dataset_owner, dataset_title))
  message(response)
}

sync(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)

# Upload File

upload_file <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  readline(sprintf("press any key to upload a file to dataset %s", dataset_url))
  response <- data.world::uploadFiles(connection = conn,
                                      dataset=sprintf("%s/%s", dataset_owner, dataset_title),
                                      paths = list ("demo/demo.txt"))
  message(response)
}
upload_file(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)

# Upload Data Frame

upload_dataframe <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  df = data.frame(a = c(1,2,3),
                  b = c(4,5,6))
  readline(sprintf("press any key to upload this data frame to dataset %s", dataset_url))
  response <- data.world::uploadDataFrame(connection = conn,
                                          fileName="sample.csv",
                                          dataFrame = df,
                                          dataset = sprintf("%s/%s", dataset_owner, dataset_title))
  message(response)
}

upload_dataframe(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)
