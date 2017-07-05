library(tidyverse)
library(stringr)

census_cities <- read_csv("data-raw/1790-2010_MASTER.csv") %>%
  gather(year, population, 5:27, convert = TRUE) %>%
  select(-ID, - CityST) %>%
  select(city = City, state = ST, everything()) %>%
  filter(population > 0) %>%
  mutate(STPLFIPS_2010 =
           if_else(STPLFIPS_2010 == "0", NA_character_, STPLFIPS_2010)) %>%
  mutate(Name_2010 =
           if_else(Name_2010 == "0", NA_character_, Name_2010))

colnames(census_cities) <- tolower(colnames(census_cities))
colnames(census_cities) <- str_replace_all(colnames(census_cities), " ", "_")

devtools::use_data(census_cities, overwrite = TRUE, compress = "xz")
