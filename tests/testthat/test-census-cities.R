test_that("census_cities has correct column names", {
  # TODO should be 2020?
  expected_cols <- c(
    "city",
    "state_name",
    "state_abbr",
    "county",
    "county_name",
    "stplfips_2010",
    "name_2010",
    "city_source",
    "population_source",
    "place_type",
    "year",
    "population",
    "geometry"
  )
  expect_equal(names(census_cities), expected_cols)
})
