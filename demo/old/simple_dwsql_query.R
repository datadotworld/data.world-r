library(data.world)

simple_query_with_dwsql <- function () {
  conn <- data.world()
  readline("press any key to run query")
  simple_query_result <- query(conn, dataset="bryon/odin-2015-2016", query="SELECT * FROM Tables")
  View(simple_query_result)
}
simple_query_with_dwsql()

