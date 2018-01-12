"data.world-r
Copyright 2018 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.
https://data.world"

dw_test_that("Config can be changed using runtime variables.",
  with_options({
    runtime_cfg <- data.world::cfg(auth_token = "RUNTIME_TOKEN")
    data.world::set_config(runtime_cfg)
    testthat::expect_equal(getOption("dw.auth_token"), "RUNTIME_TOKEN")
  }))

dw_test_that(
  "Config can be changed using default environment variables.",
  with_options(with_envvars(DW_AUTH_TOKEN = "DEFAULT_ENV_VAR_TOKEN", {
    environment_cfg <- data.world::cfg_env()
    data.world::set_config(environment_cfg)
    testthat::expect_equal(getOption("dw.auth_token"), "DEFAULT_ENV_VAR_TOKEN")
  }))
)

dw_test_that(
  "Config can be changed using custom environment variables.",
  with_options(with_envvars(MY_TEST_VAR = "CUSTOM_ENV_VAR_TOKEN", {
    environment_cfg <-
      data.world::cfg_env(auth_token_var = "MY_TEST_VAR")
    data.world::set_config(environment_cfg)
    testthat::expect_equal(getOption("dw.auth_token"), "CUSTOM_ENV_VAR_TOKEN")
  }))
)

dw_test_that("Config won't change if environment variable is not set.",
  with_options({
    auth_token <- getOption("dw.auth_token")
    environment_cfg <-
      data.world::cfg_env(auth_token_var = "MISSING_VAR")
    data.world::set_config(environment_cfg)
    testthat::expect_equal(getOption("dw.auth_token"), auth_token)
  }))

dw_test_that(
  "Config can be changed using configuration file.",
  with_options(dw.config_path = "resources/single_profile_config", {
    data.world::set_config(data.world::cfg_saved())
    testthat::expect_equal(getOption("dw.auth_token"), "SINGLE_SAVED_TOKEN")
  })
)

dw_test_that(
  "Config can be changed using configuration file and multiple profiles.",
  with_options(dw.config_path = "resources/multiple_profile_config", {
    data.world::set_config(data.world::cfg_saved(profile = "CUSTOM_PROFILE"))
    testthat::expect_equal(getOption("dw.auth_token"), "CUSTOM_SAVED_TOKEN")
  })
)

dw_test_that(
  "Config won't change using configuration file that does not exist.",
  with_options({
    auth_token <- getOption("dw.auth_token")
    options(dw.config_path = "no__a_valid____file")
    testthat::expect_warning(data.world::set_config(data.world::cfg_saved()))
    testthat::expect_equal(getOption("dw.auth_token"), auth_token)
  }))

dw_test_that(
  "Config won't change using configuration profile that does not exist.",
  with_options({
    auth_token <- getOption("dw.auth_token")
    options(dw.config_path = "resources/single_profile_config")
    testthat::expect_warning(
      data.world::set_config(
        data.world::cfg_saved(profile = "INVALID_PROFILE")))
    testthat::expect_equal(getOption("dw.auth_token"), auth_token)
  }))

dw_test_that("Config file can be created", {
  tmp_cfg <- file.path(tempdir(), "new-subdir", "config")
  with_options(dw.config_path = tmp_cfg, {
    data.world::save_config(auth_token = "TEST")
    testthat::expect(file.exists(tmp_cfg),
                     paste0("Config file created at ", tmp_cfg))
    config <- ini::read.ini(tmp_cfg)
    testthat::expect_equal(config$DEFAULT, list(auth_token = "TEST"))
  })
})

dw_test_that("Config file can be updated.", {
  tmp_cfg <- file.path(tempdir(), "config")
  file.copy("resources/single_profile_config", tmp_cfg)
  with_options(dw.config_path = tmp_cfg, {
    data.world::save_config(auth_token = "TEST")
    testthat::expect(file.exists(tmp_cfg),
                     paste0("Config file created at ", tmp_cfg))
    config <- ini::read.ini(tmp_cfg)
    testthat::expect_equal(config$DEFAULT, list(auth_token = "TEST"))
  })
})

dw_test_that("Config file can be updated with new profile.", {
  tmp_cfg <- file.path(tempdir(), "config")
  file.copy("resources/single_profile_config", tmp_cfg)
  with_options(dw.config_path = tmp_cfg, {
    data.world::save_config(auth_token = "TEST", profile = "SECOND_PROFILE")
    testthat::expect(file.exists(tmp_cfg),
                     paste0("Config file created at ", tmp_cfg))
    config <- ini::read.ini(tmp_cfg)
    testthat::expect_equal(
      config$DEFAULT, list(auth_token = "SINGLE_SAVED_TOKEN"))
    testthat::expect_equal(config$SECOND_PROFILE, list(auth_token = "TEST"))
  })
})
