library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()
default_variables = set_default_demo_variables()

# Create Dataset

create_dataset <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)

  # Construct the create dataset request
  request <- data.world::DatasetCreateRequest(
    title = dataset_title,
    visibility = "PRIVATE",
    description = "demo dataset created by data.world r-sdk " ,
    tags = c("rsdk", "sdk", "demo") ,
    licenseString = "Public Domain",
    fileCreateRequests = list(data.world::FileCreateRequest("demo1.csv",
                                                            "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv"))
  )

  # Alternatively, you can also use data.world::addFile to add addtional files after the initial create construct
  request <- data.world::addFile(request = request,
                                 name = "demo2.csv",
                                 url = "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")
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

# Replace Dataset

replace_dataset <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  request <- data.world::DatasetPutRequest(visibility = "PRIVATE",
                                           description = "replaced dataset",
                                           files = list(data.world::FileCreateOrUpdateRequest("demo3.csv",
                                                                                              "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")))

  # Alternatively, you can also use data.world::addFile to add addtional files after the initial create construct
  request <- data.world::addFile(request = request,
                                 name = "demo4.csv",
                                 url = "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")
  readline(sprintf("press any key to replace dataset %s", dataset_url))
  response <- data.world::replaceDataset(connection = data.world(), request, sprintf("%s/%s", dataset_owner, dataset_title))
  message(response)
}

replace_dataset(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)

# Patch Dataset

patch_dataset <- function (dataset_owner, dataset_title) {
  dataset_url <- dataset_url(dataset_owner, dataset_title)
  request <- data.world::DatasetPutRequest(visibility = "PRIVATE",
                                           description = "patched dataset",
                                           files = list(data.world::FileCreateOrUpdateRequest("demo5.csv",
                                                                                              "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")))

  # Alternatively, you can also use data.world::addFile to add addtional files after the initial create construct
  request <- data.world::addFile(request = request,
                                 name = "demo6.csv",
                                 url = "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv")

  readline(sprintf("press any key to patch dataset %s", dataset_url))
  response <- data.world::replaceDataset(connection = data.world(), request, sprintf("%s/%s", dataset_owner, dataset_title))
  message(response)
}

patch_dataset(dataset_owner = default_variables$dataset_owner, dataset_title = default_variables$dataset_title)


