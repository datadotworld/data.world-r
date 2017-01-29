# data.world-r

An R client for querying data.world datasets.

## Install

This library hasn't yet been added to a central package repository -
you can install it using `githubinstall` directly from this github repo:

```
> install.packages("githubinstall")
> githubinstall::gh_install_packages("datadotworld/data.world-r")
```

## Use

### Setting up the connection

Once installed, you can instantiate a connection by providing your
data.world API token to the constructor.  You can find your API
token at https://data.world/settings/advanced

you can either send the token in the constructor:
```
> library(data.world)
> conn <- data.world(token = "YOUR_API_TOKEN")
```

or you can insert your token into a `.data.world` file in your home
directory, and the constructor will read it from there:

```
echo 'token=YOUR_API_TOKEN' > ~/.data.world
```
then
```
> library(data.world)
> conn <- data.world()
```

### Querying

The client supports one method - `query`, which can be used to send a
[`dwSQL`](https://docs.data.world/tutorials/dwsql/) or a `SPARQL` query to a particular dataset's query endpoint.

`query` returns a data frame.

To get the IDs and names of all available tables:
```
> df <- query(conn, dataset="bryon/odin-2015-2016", query="SELECT * FROM Tables")
> df
# A tibble: 3 × 2
                                                      tableId                   tableName
                                                        <chr>                       <chr>
1                   ODIN-2015-2016-raw.csv/ODIN-2015-2016-raw          ODIN-2015-2016-raw
2 ODIN-2015-2016-standardized.csv/ODIN-2015-2016-standardized ODIN-2015-2016-standardized
3         ODIN-2015-2016-weighted.csv/ODIN-2015-2016-weighted     ODIN-2015-2016-weighted
```

To select one specific table, use the Name of the specific table *(note the backticks required for table names including special characters)*:
```
> df <- query(conn, dataset="bryon/odin-2015-2016", query="SELECT * FROM `ODIN-2015-2016-standardized`")
> df
# A tibble: 7,155 × 19
    Year         Region `Region code`    Country `Country Code`
   <int>          <chr>         <chr>      <chr>          <chr>
1   2015 Eastern Africa           AFE    Burundi            BDI
2   2015 Eastern Africa           AFE    Burundi            BDI
3   2015 Eastern Africa           AFE    Burundi            BDI
4   2015 Eastern Africa           AFE Madagascar            MDG
5   2015 Western Africa           AFW Mauritania            MRT
6   2015 Western Africa           AFW Mauritania            MRT
7   2015 Western Africa           AFW Mauritania            MRT
8   2015 Western Africa           AFW Mauritania            MRT
9   2015 Western Africa           AFW Mauritania            MRT
10  2015 Western Africa           AFW Mauritania            MRT
# ... with 7,145 more rows, and 14 more variables: Elements <chr>, `Indicator Coverage and
#   Disaggregation` <int>, `Data Available Last 5 Years` <int>, `Data Available Last 10 Years` <int>,
#   `First Administrative Level` <int>, `Second Administrative Level` <int>, `Coverage
#   subscore` <int>, `Machine Readable` <int>, `Non-proprietary` <int>, `Download Options` <int>,
#   `Metadata Available` <int>, `Free/ unrestricted use and reuse` <int>, `Openness subscore` <int>,
#   `Overall subscore` <int>
```

To execute a `SPARQL` query, you need to specify the `type` as
`sparql`:
```
> df <- query(conn, dataset="bryon/odin-2015-2016", type="sparql", query='
PREFIX : <http://data.world/bryon/odin-2015-2016/ODIN-2015-2016-raw.csv/ODIN-2015-2016-raw#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
SELECT *
WHERE {
  [ :Year ?year ; :Region ?region ; :Overall_subscore ?score ]
  FILTER(?year = "2015")
} 
LIMIT 10')
> df
# A tibble: 10 × 3
    year         region score
   <int>          <chr> <dbl>
1   2015 Eastern Africa   3.0
2   2015 Eastern Africa   2.5
3   2015 Eastern Africa   0.0
4   2015 Eastern Africa   2.0
5   2015 Western Africa  25.0
6   2015 Western Africa   3.0
7   2015 Western Africa   2.0
8   2015 Western Africa   0.5
9   2015 Western Africa   0.0
10  2015 Western Africa   0.0
```
