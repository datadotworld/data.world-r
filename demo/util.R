
set_default_demo_variables <- function() {
  timestamp <- strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y%m%dt%H%M%S")
  if (exists("default_dataworld_user_id")) {
    demo_dataset_owner <- readline(sprintf("enter the data.world user_id the current token belong to  (default to %s): ", default_dataworld_user_id))
    demo_dataset_owner = if (demo_dataset_owner == '') default_dataworld_user_id else demo_dataset_owner
  } else {
    demo_dataset_owner <- readline("data.world user_id the current token belong to: ")
  }

  default_dataset_title <- sprintf('demodataset%s', timestamp)
  demo_dataset_title <- readline(sprintf("enter the dataset title for this demo (default to %s) : ", default_dataset_title))
  demo_dataset_title = if (demo_dataset_title == '') default_dataset_title else demo_dataset_title
  message(sprintf("default dataset owner for this demo is set to %s", demo_dataset_owner))
  message(sprintf("default dataset title for this demo is set to %s", demo_dataset_title))
  ret <- list("dataset_owner" = demo_dataset_owner, "dataset_title" = demo_dataset_title)
  return(ret)
}

verify_token <- function() {
  conn <- data.world::data.world()
  token = conn$token
  # dumb check for valid token
  if (token == '' || is.null(token) || nchar(token) < 300) {
    message("current token appears to be invalid.")
    message("Please make sure to follow instruction on how to retrieve a data.world token.\nSee \'vignette(\"quickstart\", package = \"data.world\")\' for further instruction.")
  }
}

dataset_url <- function(dataset_owner, dataset_title) {
  dataset_url <- sprintf("https://data.world/%s/%s", dataset_owner, dataset_title)
  return(dataset_url)
}
