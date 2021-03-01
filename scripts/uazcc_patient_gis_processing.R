# set up
# packages 
library(here)
library(tidyverse)
library(tigris)
library(sf)
library(ggthemes)

# options
options(tigris_use_cache = TRUE)

# read data
az_patients <- read_rds("data/tidy/uazcc_az_patients.rds")

# select only columns for spatial analysis
az_patients_spatial <- az_patients %>%
  ungroup() %>%
  select(lng, lat)

# create spatial simple features
az_patients_spatial <- st_as_sf(x = az_patients_spatial,
         coords = c("lng", "lat"),
         crs = "NAD83")

# inspect plot 
az_patients_spatial %>%
  ggplot() +
  geom_sf() +
  geom_sf(data = roads) +
  xlim(-115, -109) +
  ylim(30, 38)

# save to disk 
st_write(az_patients_spatial, dsn = "data/tidy/gis/az_patients_spatial.shp")

