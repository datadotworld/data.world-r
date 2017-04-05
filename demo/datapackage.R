library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()
default_variables = set_default_demo_variables()

createInitialDataset <- function (ownerId, datasetId) {
  request <- data.world::DatasetCreateRequest(
    title = datasetId,
    visibility = "PRIVATE",
    description = "datapackage demo" ,
    tags = c("rsdk","demo","datapackage") ,
    licenseString = "Public Domain",
    fileCreateRequests = list(data.world::FileCreateRequest("demo1.csv",
                                                            "https://docs.google.com/spreadsheets/d/1UheyB6pxTCfLpRmIGITM0fKb8jHVEvPuajmuejxxRyE/pub?gid=1371600687&single=true&output=csv"))
  )
  # enter your data.world handler here
  response <- data.world::createDataset(
    connection = data.world(),
    createDatasetRequest = request,
    ownerId = ownerId
  )
}
createInitialDataset(ownerId = default_variables$dataset_owner, datasetId = default_variables$dataset_title)

# Download DataPackage
download_datapackage <- function (ownerId, datasetId) {
  readline(sprintf("press any key to download the datapackage for %s", dataset_url(ownerId, datasetId)))
  datapackage <- data.world::downloadDatapackage(connection = data.world() , dataset = sprintf("%s/%s", ownerId, datasetId))
  datapackage
}
introDataPackage <- download_datapackage(default_variables$dataset_owner, default_variables$dataset_title)

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


# to add a table to the data package
addTables <- function (datapackage) {
  readline(sprintf("press any key to add 2 data.frames to this datapackage"))
  datapackage <- data.world::addTable(datapackage, data.frame(a=c(1,2), b=c(3,4), c=c(7,8)), "sample")
  datapackage <- data.world::addTable(datapackage, data.frame(a=c(9,10), b=c(11,12)), "another_sample")
  return(datapackage)
}
introDataPackage <- addTables(introDataPackage)

# To delete a table froma  data package
deleteTable <- function (datapackage) {
  readline(sprintf("press any key to delete sample from this datapackage"))
  datapackage <- data.world::deleteTable(datapackage, name = 'sample')
  return(datapackage)
}
introDataPackage <- deleteTable(introDataPackage)

# To sync
syncDatapackage <- function (datapackage) {
  readline(sprintf("press any key to sync this datapackage"))
  datapackage <- data.world::sync(datapackage)
  return(datapackage)
}
introDataPackage <- syncDatapackage(introDataPackage)

# To upload a dataframe directly to dataset
uploadTestDataframe <- function(ownerId, datasetId) {
  readline(sprintf("press any key to upload a dataframe directly to a dataset"))
  data.world::uploadDataFrame(connection = data.world(),
                              fileName="demo2.csv",
                              dataFrame = data.frame(a = c(1,2,3),
                                                     b = c(4,5,6)),
                              dataset = sprintf("%s/%s", ownerId, datasetId))
}
uploadTestDataframe(ownerId = default_variables$dataset_owner, datasetId = default_variables$dataset_title)

introDataPackage <- syncDatapackage(introDataPackage)

load_tables(introDataPackage, list_tables(introDataPackage))

# update an existing table
updateExistingTable <- function(datapackage) {
  readline(sprintf("press any key to update a table from this local datapackage"))
  datapackage <- data.world::addTable(datapackage,
                                          dataframe = data.frame(a = c(1,2,3),
                                                                 b = c(4,5,6),
                                                                 c = c(7,8,9)),
                                          name = 'demo2',
                                          forceOverride = TRUE)
  return(datapackage)
}
introDataPackage <- updateExistingTable(introDataPackage)

introDataPackage <- syncDatapackage(introDataPackage)

load_tables(introDataPackage, list_tables(introDataPackage))

