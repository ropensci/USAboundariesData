# Create the RDA versions of the AHCB files. This assumes that the relevant
# shapefiles have been unzipped and put in a directory in `data-raw`.

library(tidyverse)
library(sf)
library(stringr)

states_historical_lores <- read_sf("data-raw/temp/ahcb/US_HistStateTerr_Gen05.shp",
                             stringsAsFactors = FALSE)
states_historical_hires <- read_sf("data-raw/temp/ahcb/US_HistStateTerr_Gen01.shp",
                             stringsAsFactors = FALSE)
counties_historical_lores <- read_sf("data-raw/temp/ahcb/US_HistCounties_Gen05.shp",
                               stringsAsFactors = FALSE)
counties_historical_hires <- read_sf("data-raw/temp/ahcb/US_HistCounties_Gen01.shp",
                               stringsAsFactors = FALSE)

prepare_shapefile <- function(shp) {
  colnames(shp) <- str_to_lower(colnames(shp))
  shp %>%
    mutate(state_abbr = str_to_upper(str_sub(id, 1, 2))) %>%
    left_join(USAboundaries::state_codes, by = "state_abbr") %>%
    mutate(state_abbr = if_else(is.na(state_name), NA_character_, state_abbr)) %>%
    select(-jurisdiction_type)
}

states_historical_lores <- prepare_shapefile(states_historical_lores)
states_historical_hires <- prepare_shapefile(states_historical_hires)
counties_historical_lores <- prepare_shapefile(counties_historical_lores)
counties_historical_hires <- prepare_shapefile(counties_historical_hires)

devtools::use_data(states_historical_lores, overwrite = TRUE, compress = "xz")
devtools::use_data(states_historical_hires, overwrite = TRUE, compress = "xz")
devtools::use_data(counties_historical_lores, overwrite = TRUE, compress ="xz")
devtools::use_data(counties_historical_hires, overwrite = TRUE, compress = "xz")
