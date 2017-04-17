library(data.world)

# The main SDK exposes  2 functions
# Declare and load a dataset dependency via data.world::loadDataset
dataset_url <- 'https://data.world/jonloyens/an-intro-to-dataworld-dataset'
readline(sprintf("press any key to load dataset %s", dataset_url))
dataset <- data.world::loadDataset('https://data.world/jonloyens/an-intro-to-dataworld-dataset')
readline(sprintf("press any key to explore dataset %s", dataset_url))
# this dataset is of class `LocalDataset`
class(dataset)
summary(dataset)
# one can access tables available in a dataset as an R data.frame via LocalDataset$tables
# e.g
readline(sprintf("press any key to view tables in %s", dataset_url))
names(dataset$tables)
View(dataset$tables$datadotworldbballstats)
readline(sprintf("press any key to view another table in %s", dataset_url))
View(dataset$tables$datadotworldbballteam)
# Query
# Alternatively, one can also access data via data.world::query
# e.g
readline(sprintf("press any key to run query %s against %s",'select * from DataDotWorldBBallTeam', dataset_url))
View(data.world::query(dataset = 'https://data.world/jonloyens/an-intro-to-dataworld-dataset', query = 'select * from DataDotWorldBBallTeam'))
