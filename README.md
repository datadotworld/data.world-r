# data.world-r

An R client for interact with data.world platform.

## Install

This library hasn't yet been added to a central package repository.
To get the current development version from github:
```
# install.packages("devtools")
devtools::install_github("datadotworld/data.world-r", build_vignettes = TRUE, force = TRUE)
# For datapackage (http://frictionlessdata.io/data-packages/) related operations
devtools::install_github("ropenscilabs/jsonvalidate")
devtools::install_github("datadotworld/datapkg")
```

## Vignette 
To display the quickstart guide use
```
vignette("quickstart", package="data.world")
```

## Demo
To display the data.world demo interface
1.  First, set up your data.world connection per the `quickstart` vignette
2.  (Optional) you can set your default dataworld userid by 
```
default_dataworld_user_id <- YOUR_DATAWORLD_USER_ID
```
2.  Run the following command from your R env
```
demo(package = "data.world")
# e.g
demo(package = "data.world" , topic ="dataset_management")
```
