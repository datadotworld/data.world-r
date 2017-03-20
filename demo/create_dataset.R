library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()
set_default_demo_variables()


create_dataset <- function (dataset_owner, dataset_title) {
  # Construct the create dataset request
  request <- data.world::DatasetCreateRequest(
    title = dataset_title,
    visibility = "PRIVATE",
    description = "demo dataset created by data.world r-sdk" ,
    tags = c("rsdk", "sdk", "demo") ,
    licenseString = "Public Domain"
  )

  # Create the dataset
  data.world::createDataset(
    connection = data.world(),
    createDatasetRequest = request,
    ownerId = dataset_owner
  )

  message(sprintf("a demo dataset has been created https://data.world/%s/%s", user_id, dataset_title))
}


create_dataset(dataset_owner = demo_dataset_owner, dataset_title = demo_dataset_title)
