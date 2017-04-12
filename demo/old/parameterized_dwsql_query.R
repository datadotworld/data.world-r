parameterized_query_with_dwsql_string <- function() {
  conn <- data.world()
  readline("press any key to run query")
  query_result <- query(conn,
                        dataset="bryon/odin-2015-2016",
                        query="SELECT * FROM `ODIN-2015-2016-standardized` WHERE `Year` = ? AND `Country Code` = ?",
                        queryParameters = list("2015", "BDI"))

  View(query_result)
}

parameterized_query_with_dwsql_string()


parameterized_query_with_dwsql_decimal <- function() {
  conn <- data.world()
  readline("press any key to run query")
  query_result <- query(conn,
                        dataset="bryon/odin-2015-2016",
                        query="SELECT * FROM `ODIN-2015-2016-standardized` WHERE `Indicator Coverage and Disaggregation` < ? ",
                        queryParameters = list(5.5))
  View(query_result)
}
parameterized_query_with_dwsql_decimal()
