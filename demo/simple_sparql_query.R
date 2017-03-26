library(data.world)

simple_query_with_sparql <- function () {
  conn <- data.world()
  readline("press any key to run query")
  simple_query_result <- query(conn, dataset="bryon/odin-2015-2016", type = "sparql", query=
"PREFIX : <http://data.world/bryon/odin-2015-2016/ODIN-2015-2016-raw.csv/ODIN-2015-2016-raw#>
 PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
 SELECT *
 WHERE {
 [ :Year ?year ; :Region ?region ; :Overall_subscore ?score ]
 FILTER(?year = \"2015\")
 }
 LIMIT 10")
  View(simple_query_result)
}
simple_query_with_sparql()

