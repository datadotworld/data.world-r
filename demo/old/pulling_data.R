library(data.world)
source("demo/util.R", echo = FALSE)

verify_token()

# Get Dataset
get_dataset <- function() {
  datasetid = 'jonloyens/an-intro-to-dataworld-dataset'
  readline(sprintf ("press any key to download the metadata for https://data.world/%s", datasetid))
  dataset_detail <-  data.world::getDataset(connection = data.world(), dataset=datasetid)
  return(dataset_detail)
}
dataset_detail <-  get_dataset()


# Viewing metadata
view_dataset_detail <- function(dataset_detail) {
  title = dataset_detail$title
  owner = dataset_detail$owner
  all_fields = names(dataset_detail)
  message(sprintf("dataset fields to explore : %s", paste(all_fields, collapse = " ,")))
  readline(sprintf("press any key to view the metadata for %s by %s ", title, owner))
  View(data.frame("field"=c("owner", "title" , "visibility", "license"),
                  "value"=c(dataset_detail$owner , dataset_detail$title, dataset_detail$visibility, dataset_detail$license)))
}

view_dataset_detail(dataset_detail)

# View file details
view_files_detail <- function(dataset_detail) {
  title = dataset_detail$title
  owner = dataset_detail$owner
  files <- dataset_detail$files
  file_info <- paste(lapply(files, function (file) {file$name}) , collapse = ", ")
  readline(sprintf("press any key to view the file details for %s by %s ", title, owner))
  message(sprintf("dataset %s by %s has files : %s ", title, owner, file_info))
  file_info_df <- data.frame(name = unlist(lapply(test$files, function (file) {file$name})) ,
                             size = unlist(lapply(test$files, function (file) {file$size})))
  View(file_info_df)
}
view_files_detail(dataset_detail)


# Download File as Data Frame
download_file_as_dataframe <- function(dataset_detail) {
    owner <- dataset_detail$owner
    id <- dataset_detail$id
    readline(sprintf("press any key to start download csv files as data.frame for \"%s\" by %s ", id, owner))

    for (i in 0:(length(dataset_detail$files)-1)) {
      file <- dataset_detail$files[[i+1]]
      if (endsWith(file$name, '.csv')) {
        readline(sprintf("press any key to download and view file %s", file$name))
        csv_df <- data.world::downloadFileAsDataFrame(connection = data.world(),
                                                              dataset=sprintf("%s/%s", owner, id),
                                                              fileName = file$name)
        View(csv_df)
      }
    }

}
download_file_as_dataframe(dataset_detail)
