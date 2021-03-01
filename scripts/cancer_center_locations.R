# set up
# packages 
library(here)
library(tidyverse)
library(sf)

# data 
uacc_locations <- tribble(
  ~uacc_location, ~lat, ~lng,
  "uacc_north", 32.27651366469708, -110.9431766306317,
  "uacc_orange_grove", 32.32233374883004, -111.00660891528784
)

# convert to spatial 
# create spatial simple features
uacc_locations_spatial <- st_as_sf(x = uacc_locations,
                                coords = c("lng", "lat"),
                                crs = "NAD83")

# visualize to confirm 
uacc_locations_spatial %>%
  ggplot() +
  geom_sf() +
  xlim(-115, -109) +
  ylim(30, 38)

# save to disk 
st_write(uacc_locations_spatial, dsn = "data/tidy/gis/uazcc_locations/uacc_locations_spatial.shp")

