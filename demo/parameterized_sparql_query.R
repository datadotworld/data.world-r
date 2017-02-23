library(data.world)

parameterized_query_with_sparql_string <- function () {
  conn <- data.world()
  readline("press any key to run query")
  result <- query(conn, dataset="bryon/odin-2015-2016", type = "sparql",
                  query=
                  "PREFIX : <http://data.world/bryon/odin-2015-2016/ODIN-2015-2016-raw.csv/ODIN-2015-2016-raw#>
                  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
                  SELECT *
                  WHERE {
                  [ :Year ?year ; :Region ?region ; :Overall_subscore ?score ]
                  FILTER(?region = $v1)
                  }
                  LIMIT 10
                  ",
                  queryParameters = list("$v1"="Western Africa"))
  View(result)
  }
parameterized_query_with_sparql_string()

parameterized_query_with_sparql_decimal <- function () {
  conn <- data.world()
  readline("press any key to run query")
  result <- query(conn, dataset="bryon/odin-2015-2016", type = "sparql",
                  query=
                    "PREFIX : <http://data.world/bryon/odin-2015-2016/ODIN-2015-2016-raw.csv/ODIN-2015-2016-raw#>
                    PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
                  SELECT *
                  WHERE {
                  [ :Year ?year ; :Region ?region ; :Indicator_Coverage_and_Disaggregation ?score ]
                  FILTER(?score > $v1)
                  }
                  LIMIT 10",
                  queryParameters = list("$v1"=5.5))
  View(result)
}
parameterized_query_with_sparql_decimal()
