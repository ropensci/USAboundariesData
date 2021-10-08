library(tidyverse)
library(stringr)
library(sf)

census_cities <- read_csv("data-raw/1790-2010_MASTER.csv",
                          col_types = cols(
                            .default = col_integer(),
                            ST = col_character(),
                            City = col_character(),
                            CityST = col_character(),
                            STPLFIPS_2010 = col_character(),
                            Name_2010 = col_character(),
                            County = col_character(),
                            LAT = col_double(),
                            LON = col_double(),
                            LAT_BING = col_double(),
                            LON_BING = col_double(),
                            `City Source` = col_character(),
                            `Population Source` = col_character(),
                            `Place Type` = col_character(),
                            County_Name = col_character()
                          )) %>%
  gather(year, population, 5:27, convert = TRUE) %>%
  select(-ID, - CityST) %>%
  select(city = City, state_abbr = ST, everything()) %>%
  filter(population > 0) %>%
  mutate(STPLFIPS_2010 =
           if_else(STPLFIPS_2010 == "0", NA_character_, STPLFIPS_2010)) %>%
  mutate(Name_2010 =
           if_else(Name_2010 == "0", NA_character_, Name_2010)) %>%
  mutate(longitude = if_else(!is.na(LON), LON, LON_BING),
         latitude = if_else(!is.na(LAT), LAT, LAT_BING)) %>%
  filter(!near(longitude, 0),
         !near(latitude, 0)) %>%
  select(-LON, -LAT, -LON_BING, -LAT_BING) %>%
  left_join(select(USAboundaries::state_codes, state_name, state_abbr), by = "state_abbr") %>%
  select(city, state_name, state_abbr, County, County_Name, everything()) %>%
  st_as_sf(coords = c("longitude", "latitude"))

load("data/states_contemporary_lores.rda")
boundaries <- states_contemporary_lores %>%
  st_union()

st_crs(census_cities) <- st_crs(boundaries)

colnames(census_cities) <- tolower(colnames(census_cities))
colnames(census_cities) <- str_replace_all(colnames(census_cities), " ", "_")

usethis::use_data(census_cities, overwrite = TRUE, compress = "xz")
