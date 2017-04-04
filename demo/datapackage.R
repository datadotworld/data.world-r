library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()

# Download DataPackage
download_datapackage <- function (ownerId, datasetId) {
  readline(sprintf("press any key to download the datapackage for %s", dataset_url(ownerId, datasetId)))
  datapackage <- data.world::downloadDatapackage(connection = data.world() , dataset = sprintf("%s/%s", ownerId, datasetId))
  datapackage
}
introDataPackage <- download_datapackage("jonloyens", "an-intro-to-dataworld-dataset")

# The returned object is an s3 object of class "DataPackage"
class(introDataPackage)
# List of methods available for class "Datapackage"
methods(class = "DataPackage")

# List Data Package tables
list_tables <- function (datapackage) {
  readline(sprintf("press any key to list datapackage %s 's tables", datapackage$dataset))
  data.world::listTables(datapackage)
}
introDatasetTables <- list_tables(introDataPackage)
message(paste(introDatasetTables, collapse = ", "))

# Load Data Package tables
load_tables <- function (datapackage, tables) {
  for (table in tables) {
    readline(sprintf("press any key to view table %s", table))
    View(data.world::loadTable(datapackage, table))
  }
}
load_tables(introDataPackage, introDatasetTables)

# Load Schema
load_schema <- function (datapackage, tables) {
  for (table in tables) {
    readline(sprintf("press any key to view table %s's schema", table))
    View(data.world::loadSchema(datapackage, table))
  }
}

load_schema(introDataPackage, introDatasetTables)

