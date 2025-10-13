library(tidyverse)
library(sf)
library(stringr)

# TODO USAboundaries::states_contemporary_lores keep here?

zipfiles <- c(
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_state_20m.zip",
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_state_500k.zip",
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_county_20m.zip",
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_county_500k.zip",
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_cd119_20m.zip",
  "http://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_cd119_500k.zip",
  "http://www2.census.gov/geo/tiger/GENZ2019/shp/cb_2019_us_zcta510_500k.zip"
)

zip_dir <- "data-raw/temp/census-shapefiles/"
dir.create(zip_dir, showWarnings = FALSE, recursive = TRUE)

walk(zipfiles, function(url) {
  file <- str_c(zip_dir, basename(url))
  if (!file.exists(file)) {
    message("Downloading ", url)
    download.file(url, file, mode = "wb")
  }
})

walk(zipfiles, function(x) {
  file <- str_c(zip_dir, basename(x))
  message("Unzipping ", x)
  unzip(file, exdir = zip_dir, overwrite = TRUE)
})

cleanup_shp <- function(f, join = TRUE) {
  shp <- f |>
    str_c(zip_dir, .) |>
    st_read(stringsAsFactors = FALSE) |>
    st_transform(4326)

  if (join) {
    shp <- shp |>
      left_join(USAboundaries::state_codes, by = c("STATEFP" = "state_code"))
  }

  colnames(shp) <- str_to_lower(colnames(shp))

  # Remove duplicated 'state_name' in counties
  shp <- shp[, !duplicated(names(shp))]
  shp
}

states_contemporary_lores <- cleanup_shp("cb_2024_us_state_20m.shp")
states_contemporary_hires <- cleanup_shp("cb_2024_us_state_500k.shp")
counties_contemporary_lores <- cleanup_shp("cb_2024_us_county_20m.shp")
counties_contemporary_hires <- cleanup_shp("cb_2024_us_county_500k.shp")
congress_contemporary_lores <- cleanup_shp("cb_2024_us_cd119_20m.shp")
congress_contemporary_hires <- cleanup_shp("cb_2024_us_cd119_500k.shp")
zcta <- cleanup_shp("cb_2019_us_zcta510_500k.shp", join = FALSE)
zipcodes <- zcta |>
  st_transform(3857) |>
  st_centroid() |>
  mutate(zipcode = zcta5ce10) |>
  select(zipcode, everything()) |>
  st_transform(4326)

usethis::use_data(
  states_contemporary_hires,
  states_contemporary_lores,
  counties_contemporary_hires,
  counties_contemporary_lores,
  congress_contemporary_hires,
  congress_contemporary_lores,
  zipcodes,
  compress = "xz",
  overwrite = TRUE
)
