# Which FQHC locations are in the catchment 
# René Dario Herrera 
# renedherrera at email dot arizona dot edu
# 29 June 2021

# load packages
library(here)
library(tidyverse)
library(sf)
library(tigris)

# options 
options(tigris_use_cache = TRUE)

# set variables 
catchment_county_list <- c("Yuma County", "Pinal County", "Pima County", "Cochise County", "Santa Cruz County")

# read data
# az county shapefiles
az_counties <- read_rds("data/tidy/az_counties_sf.rds")

# fqhc data 
fqhc_df <- read_rds("data/tidy/fqhc_list.rds")

# which fqhc locations are in the catchment?
fqhc_in_catchment <- fqhc_df %>%
  filter(county %in% catchment_county_list)

# which fqhc locations are in Yuma County?
fqhc_in_yuma <- fqhc_df %>%
  filter(county == "Yuma County")

# which fqhc locations are in Pinal County?
fqhc_in_pinal <- fqhc_df %>%
  filter(county == "Pinal County")

# which fqhc locations are in Pima County?
fqhc_in_pima <- fqhc_df %>%
  filter(county == "Pima County")

# which fqhc locations are in Cochise County?
fqhc_in_cochise <- fqhc_df %>%
  filter(county == "Cochise County")

# which fqhc locations are in Santa Cruz County?
fqhc_in_sc <- fqhc_df %>%
  filter(county == "Santa Cruz County")

# Show the catchment
az_counties %>%
  filter(NAMELSAD %in% catchment_county_list) %>%
  ggplot() +
  geom_sf()
