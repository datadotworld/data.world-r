## Note to reviewers:

Please note that `data.world::save_config()` is designed to help users
cache their data.world API token for convenience. 
As such, it uses the user's home directory by default.

## Test environments

* local OS X install, R 3.4.4
* CircleCI Ubuntu, Release and Devel
* win-builder (all versions)

## R CMD check results

There were no ERRORs or WARNINGs.

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
```
Maintainer: 'Rafael Pereira <rafael.pereira@data.world>'

Possibly mis-spelled words in DESCRIPTION:
  integrations (14:5)

Found the following (possibly) invalid URLs:
  URL: https://circleci.com/gh/datadotworld/data.world-r
    From: README.md
    Status: 404
    Message: Not Found
  URL: https://data.world
    From: README.md
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://data.world/jonloyens/an-intro-to-dataworld-dataset/query
    From: inst/doc/query.html
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://data.world/jonloyens/intermediate-data-world/query
    From: inst/doc/query.html
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://data.world/settings/advanced
    From: inst/doc/quickstart.html
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://github.com/datadotworld/data.world-r
    From: DESCRIPTION
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://github.com/datadotworld/data.world-r/issues
    From: DESCRIPTION
    Status: Error
    Message: libcurl error code 35
    	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
  URL: https://meta.data.world/introducing-data-projects-e7cfa971b552
    From: inst/doc/quickstart.html
          README.md
    Status: 409
    Message: Conflict
  URL: https://meta.data.world/showcasing-your-data-work-using-insights-9c578698275b
    From: inst/doc/quickstart.html
          README.md
    Status: 409
    Message: Conflict
```

Comments:
- "integrations" is not misspelled.
- All links have been tested by hand and they work correctly.

## Downstream dependencies

No ERRORs or WARNINGs found :)
