library(tidyverse)
library(sf)
library(stringr)
library(USAboundaries)
library(devtools)

baseurl <- "http://www2.census.gov/geo/tiger/GENZ2016/shp/"
zipfiles <- c("cb_2016_us_state_20m.zip",
              "cb_2016_us_state_500k.zip",
              "cb_2016_us_county_20m.zip",
              "cb_2016_us_county_500k.zip",
              "cb_2016_us_cd115_20m.zip",
              "cb_2016_us_cd115_500k.zip",
              "cb_2016_us_zcta510_500k.zip")

zip_dir <- "data-raw/temp/census-shapefiles/"
dir.create(zip_dir, showWarnings = FALSE, recursive = TRUE)

walk(zipfiles, function(x) {
  url <- str_c(baseurl, x)
  file <- str_c(zip_dir, x)
  if (!file.exists(file)) {
    message("Downloading ", x)
    download.file(url, file, mode = "wb")
  }
})

walk(zipfiles, function(x) {
  file <- str_c(zip_dir, x)
  message("Unzipping ", x)
  unzip(file, exdir = zip_dir, overwrite = TRUE)
})

cleanup_shp <- function(f, join = TRUE) {
  shp <- f %>%
    str_c(zip_dir, .) %>%
    st_read(stringsAsFactors = FALSE) %>%
    st_transform(4326)

  if (join) {
    shp <- shp %>%
      left_join(USAboundaries::state_codes, by = c("STATEFP" = "state_code"))
  }

  colnames(shp) <- str_to_lower(colnames(shp))
  shp
}

states_contemporary_lores <- cleanup_shp("cb_2016_us_state_20m.shp")
states_contemporary_hires <- cleanup_shp("cb_2016_us_state_500k.shp")
counties_contemporary_lores <- cleanup_shp("cb_2016_us_county_20m.shp")
counties_contemporary_hires <- cleanup_shp("cb_2016_us_county_500k.shp")
congress_contemporary_lores <- cleanup_shp("cb_2016_us_cd115_20m.shp")
congress_contemporary_hires <- cleanup_shp("cb_2016_us_cd115_500k.shp")
zcta <- cleanup_shp("cb_2016_us_zcta510_500k.shp", join = FALSE)
zipcodes <- zcta %>%
  st_transform(3857) %>%
  st_centroid() %>%
  mutate(zipcode = zcta5ce10) %>%
  select(zipcode, everything()) %>%
  st_transform(4326)

use_data(states_contemporary_hires,
         states_contemporary_lores,
         counties_contemporary_hires,
         counties_contemporary_lores,
         congress_contemporary_hires,
         congress_contemporary_lores,
         zipcodes,
         compress = "xz", overwrite = TRUE)

file.rename("data/states_contemporary_lores.rda", "../USAboundaries/data/states_contemporary_lores.rda")
