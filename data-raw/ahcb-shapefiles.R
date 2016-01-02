# Download the state and county shapefiles from Atlas of Historical County
# Boundaries. Use the generalized files.

library(stringi)
library(devtools)
library(rgdal)
library(ggplot2)
library(lubridate)
library(dplyr)

# States
states_url <- "http://publications.newberry.org/ahcbp/downloads/gis/US_AtlasHCB_StateTerr_Gen05.zip"
states_url_hires <- "http://publications.newberry.org/ahcbp/downloads/gis/US_AtlasHCB_StateTerr_Gen01.zip"

if(!file.exists("data-raw/states.zip")) {
  download.file(states_url, "data-raw/states.zip")
}

if(!file.exists("data-raw/states-hires.zip")) {
  download.file(states_url_hires, "data-raw/states-hires.zip")
}

unzip("data-raw/states.zip", exdir = "data-raw/", unzip = getOption("unzip"))
unzip("data-raw/states-hires.zip", exdir = "data-raw/", unzip = getOption("unzip"))

hist_us_states <- readOGR(
  "data-raw/US_AtlasHCB_StateTerr_Gen05/US_HistStateTerr_Gen05_Shapefile",
  "US_HistStateTerr_Gen05")

hist_us_states_hires <- readOGR(
  "data-raw/US_AtlasHCB_StateTerr_Gen01/US_HistStateTerr_Gen01_Shapefile",
  "US_HistStateTerr_Gen01")

hist_us_states@data <-  hist_us_states@data %>%
  mutate(START_POSIX = ymd(START_N),
         END_POSIX = ymd(END_N))

hist_us_states_hires@data <-  hist_us_states_hires@data %>%
  mutate(START_POSIX = ymd(START_N),
         END_POSIX = ymd(END_N))

colnames(hist_us_states@data) <- colnames(hist_us_states@data) %>%
  tolower()
colnames(hist_us_states_hires@data) <- colnames(hist_us_states_hires@data) %>%
  tolower()

use_data(hist_us_states, overwrite = TRUE, compress = "xz")
use_data(hist_us_states_hires, overwrite = TRUE, compress = "xz")

# Counties
counties_url <- "http://publications.newberry.org/ahcbp/downloads/gis/US_AtlasHCB_Counties_Gen05.zip"
counties_url_hires <- "http://publications.newberry.org/ahcbp/downloads/gis/US_AtlasHCB_Counties_Gen01.zip"

if(!file.exists("data-raw/counties.zip")) {
  download.file(counties_url, "data-raw/counties.zip")
}

if(!file.exists("data-raw/counties-hires.zip")) {
  download.file(counties_url_hires, "data-raw/counties-hires.zip")
}

unzip("data-raw/counties.zip", exdir = "data-raw/", unzip = getOption("unzip"))
unzip("data-raw/counties-hires.zip", exdir = "data-raw/", unzip = getOption("unzip"))

hist_us_counties <- readOGR(
  "data-raw/US_AtlasHCB_Counties_Gen05/US_HistCounties_Gen05_Shapefile",
  "US_HistCounties_Gen05")

hist_us_counties_hires <- readOGR(
  "data-raw/US_AtlasHCB_Counties_Gen01/US_HistCounties_Gen01_Shapefile",
  "US_HistCounties_Gen01")

hist_us_counties@data <-  hist_us_counties@data %>%
  mutate(CHANGE = stri_trans_general(CHANGE, "latin-ascii"),
         NAME_START = stri_trans_general(NAME_START, "latin-ascii"),
         FULL_NAME = stri_trans_general(FULL_NAME, "latin-ascii"),
         NAME = stri_trans_general(NAME, "latin-ascii"),
         START_POSIX = ymd(START_N),
         END_POSIX = ymd(END_N))

hist_us_counties_hires@data <-  hist_us_counties_hires@data %>%
  mutate(CHANGE = stri_trans_general(CHANGE, "latin-ascii"),
         NAME_START = stri_trans_general(NAME_START, "latin-ascii"),
         FULL_NAME = stri_trans_general(FULL_NAME, "latin-ascii"),
         NAME = stri_trans_general(NAME, "latin-ascii"),
         START_POSIX = ymd(START_N),
         END_POSIX = ymd(END_N))

colnames(hist_us_counties@data) <- colnames(hist_us_counties@data) %>%
  tolower()
colnames(hist_us_counties_hires@data) <- colnames(hist_us_counties_hires@data) %>%
  tolower()

use_data(hist_us_counties, overwrite = TRUE, compress = "xz")
use_data(hist_us_counties_hires, overwrite = TRUE, compress = "xz")
