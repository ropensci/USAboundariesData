test_that("states_historical_lores has correct column names", {
  expected_cols <- c(
    "id_num",
    "name",
    "id",
    "version",
    "start_date",
    "end_date",
    "change",
    "citation",
    "start_n",
    "end_n",
    "area_sqmi",
    "terr_type",
    "full_name",
    "abbr_name",
    "name_start",
    "geometry",
    "state_abbr",
    "state_name",
    "state_code"
  )
  expect_equal(names(states_historical_lores), expected_cols)
  expect_equal(names(states_historical_hires), expected_cols)
})


test_that("counties_historical_lores has correct column names", {
  expected_cols <- c(
    "id_num",
    "name",
    "id",
    "state_terr",
    "fips",
    "version",
    "start_date",
    "end_date",
    "change",
    "citation",
    "start_n",
    "end_n",
    "area_sqmi",
    "cnty_type",
    "full_name",
    "cross_ref",
    "name_start",
    "geometry",
    "state_abbr",
    "state_name",
    "state_code"
  )
  expect_equal(names(counties_historical_lores), expected_cols)
  expect_equal(names(counties_historical_hires), expected_cols)
})
