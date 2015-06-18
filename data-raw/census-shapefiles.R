library(plyr)
library(rgdal)
library(devtools)
library(dplyr)

baseurl <- "http://www2.census.gov/geo/tiger/GENZ2014/shp/"
zipfiles <- c("cb_2014_us_state_500k.zip",
              "cb_2014_us_state_5m.zip",
              "cb_2014_us_county_500k.zip",
              "cb_2014_us_county_5m.zip",
              "cb_2014_us_cd114_500k.zip",
              "cb_2014_us_cd114_5m.zip"
              # "cb_2014_us_zcta510_500k.zip",
              # "cb_2014_us_ua10_500k.zip"
              )

l_ply(zipfiles, function(x) {
  url <- paste0(baseurl, x)
  file <- paste0("data-raw/", x)
  if (!file.exists(file)) {
    message("Downloading ", x)
    download.file(url, file, mode = "wb")
  }
})

l_ply(zipfiles, function(x) {
  file <- paste0("data-raw/", x)
  message("Unzipping ", x)
  unzip(file, exdir = "data-raw")
})

shapefiles <- Sys.glob("data-raw/*.shp")
shapefiles <- gsub(".shp", "", shapefiles)
shapefiles <- gsub("data-raw/", "", shapefiles)

l_ply(shapefiles, function(x) {
  shp <- readOGR("data-raw", x)
  names(shp) <- tolower(names(shp))
  shp@data[] <- lapply(shp@data, iconv, "UTF-8", "ASCII")
  assign(x, shp, envir = globalenv())
})


state_geoid <- cb_2014_us_state_5m@data %>%
  select(statefp, name) %>%
  rename(state_name = name) %>%
  distinct()

cb_2014_us_county_5m@data <- cb_2014_us_county_5m@data %>%
  left_join(state_geoid, by = c("statefp" = "statefp"))

cb_2014_us_county_500k@data <- cb_2014_us_county_500k@data %>%
  left_join(state_geoid, by = c("statefp" = "statefp"))

cb_2014_us_cd114_5m@data <- cb_2014_us_cd114_5m@data %>%
  left_join(state_geoid, by = c("statefp" = "statefp"))

cb_2014_us_cd114_500k@data <- cb_2014_us_cd114_500k@data %>%
  left_join(state_geoid, by = c("statefp" = "statefp"))

use_data(cb_2014_us_county_500k,
         cb_2014_us_county_5m,
         cb_2014_us_state_500k,
         cb_2014_us_state_5m,
         cb_2014_us_ua10_500k,
         cb_2014_us_cd114_5m,
         cb_2014_us_cd114_500k,
         # cb_2014_us_zcta510_500k,
         compress = "xz", overwrite = TRUE)
