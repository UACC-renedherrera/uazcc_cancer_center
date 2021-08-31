# set up
# packages 
library(here)
library(tidyverse)
library(tigris)
library(sf)
library(ggthemes)

# # source script
# uacc_locations_spatial <- st_read(dsn = "data/tidy/gis/uazcc_locations/uacc_locations_spatial.shp")
# 
# options
options(tigris_use_cache = TRUE)

# from tigrist 
# get AZ state and county boundary 
az_boundaries <- counties(state = "AZ")
# get national primary roads 
roads <- primary_roads()

# read data
az_patients <- read_rds("data/tidy/uazcc_az_patients.rds")

# choropleth of patients per county 
patient_per_county <- az_patients %>%
  ungroup() %>%
  group_by(county) %>%
  summarise(sum = sum(count))

# chart 
patient_per_county %>%
  arrange(desc(sum)) %>%
  ggplot() +
  geom_col(mapping = aes(x = reorder(county, sum), y = sum)) +
  coord_flip()

# patient_per_county_spatial <- inner_join(x = patient_per_county,
#            y = az_boundaries,
#            by = c("county" = "NAMELSAD"))

patient_per_county_spatial <- geo_join(
  spatial_data = az_boundaries,
  data_frame = patient_per_county,
  by_sp = "NAMELSAD",
  by_df = 'county',
  how = "inner"
)

class(patient_per_county_spatial)


# plot 
ggplot(data = patient_per_county_spatial) +
  geom_sf(mapping = aes(fill = sum)) +
  scale_fill_viridis_c()


# select only columns for spatial analysis
az_patients_spatial <- az_patients %>%
  ungroup() %>%
  mutate(location = "id")

class(az_patients_spatial)

# create spatial simple features
az_patients_spatial <- st_as_sf(x = az_patients_spatial,
         coords = c("lng", "lat"),
         crs = "NAD83")

class(az_patients_spatial)

# inspect plot 
ggplot() +
  geom_sf(data = az_boundaries) +
  geom_sf(data = roads$geometry, color = "blue", alpha = .6) +
  geom_sf(data = az_patients_spatial, alpha = .4) +
  geom_sf(data = uacc_locations_spatial, color = "red", alpha = .8) +
  xlim(-115, -109) +
  ylim(30, 38) +
  theme_map() +
  labs(title = "UACC Patients in AZ",
       subtitle = "Year 2019",
       caption = "Source: Compiled patient data")
 
 ggsave(
   filename = "figures/maps/uazcc_patients.png"
 )

# save to disk 
st_write(az_patients_spatial, 
         dsn = "data/tidy/gis/az_patients_spatial.shp",
         #delete_layer = TRUE,
         layer = "location")

