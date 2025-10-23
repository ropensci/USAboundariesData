test_that("congress_contemporary has correct column names", {
  expected_cols <- c(
    "statefp",
    "cd119fp",
    "geoidfq",
    "geoid",
    "namelsad",
    "lsad",
    "cdsessn",
    "aland",
    "awater",
    "state_name",
    "state_abbr",
    "jurisdiction_type",
    "geometry"
  )
  expect_equal(names(congress_contemporary_hires), expected_cols)
  expect_equal(names(congress_contemporary_lores), expected_cols)
})

test_that("counties_contemporary has correct column names", {
  expected_cols <- c(
    "statefp",
    "countyfp",
    "countyns",
    "geoidfq",
    "geoid",
    "name",
    "namelsad",
    "stusps",
    "state_name",
    "lsad",
    "aland",
    "awater",
    "state_abbr",
    "jurisdiction_type",
    "geometry"
  )
  expect_equal(names(counties_contemporary_hires), expected_cols)
  expect_equal(names(counties_contemporary_lores), expected_cols)
})

test_that("states_contemporary has correct column names", {
  expected_cols <- c(
    "statefp",
    "statens",
    "geoidfq",
    "geoid",
    "stusps",
    "name",
    "lsad",
    "aland",
    "awater",
    "state_name",
    "state_abbr",
    "jurisdiction_type",
    "geometry"
  )
  expect_equal(names(states_contemporary_hires), expected_cols)

  expected_states <- subset(
    states_contemporary_hires,
    jurisdiction_type == "state"
  )
  expect_equal(nrow(expected_states), 50)

  # expect_equal(names(states_contemporary_lores), expected_cols)
  #
  # expected_states <- subset(
  #   states_contemporary_lores,
  #   jurisdiction_type == "state"
  # )
  # expect_equal(nrow(expected_states), 50)
})

test_that("zipcodes has correct column names", {
  expected_cols <- c(
    "zipcode",
    "zcta5ce10",
    "affgeoid10",
    "geoid10",
    "aland10",
    "awater10",
    "geometry"
  )
  expect_equal(names(zipcodes), expected_cols)
})
