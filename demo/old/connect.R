library(data.world)
source("demo/util.R", echo = FALSE)

connect <- function () {
  conn <- data.world::data.world()
  verify_token()
}
connect()
