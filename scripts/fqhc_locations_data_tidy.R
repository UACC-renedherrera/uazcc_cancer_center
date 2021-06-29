# produce spatial point data from AZ FQHC data
# René Dario Herrera 
# renedherrera at email dot arizona dot edu
# 29 June 2021

# load packages
library(here)
library(tidyverse)
library(readxl)
library(janitor)
library(sf)
library(tmap)
library(tmaptools)
library(tigris)

# options 
options(tigris_use_cache = TRUE)

# read data
fqhc_df <- read_excel("data/raw/Copy of FQHCs.xlsx",
  col_names = TRUE
) %>%
  clean_names()

# inspect
glimpse(fqhc_df)

# tidy, keep only rows with data in bhcmisid because all others are satellites
fqhc_grantees <- fqhc_df %>%
  drop_na(bhcmisid)

# tidy, keep only rows with satellite data
fqhc_satellites <- fqhc_df %>%
  filter(is.na(bhcmisid)) %>%
  filter(is.na(uds_number)) %>%
  select(
    bphc_site_number = grantee_name,
    satellite_name = address,
    site_type = city,
    site_status = state,
    site_type_designation = zip_code,
    address = county,
    city = contact_name,
    state = telephone,
    zip_code = email,
    county = x12,
    telephone = x13,
    date_added = x14
  )

# combine fqhc into one data frame 
fqhc_df <- full_join(fqhc_grantees, fqhc_satellites) 

# remove empty columns 
fqhc_df <- fqhc_df %>%
  select(!(x12:x14))

# save to disk
write_rds(fqhc_df, "data/tidy/fqhc_list.rds")

# attempt to geocode addresses 
# grantees first
# clean up address names 
fqhc_grantees$address <- str_remove(fqhc_grantees$address, " Ste .+")
fqhc_grantees$address <- str_remove(fqhc_grantees$address, " Bldg .+")
fqhc_grantees$address <- str_remove(fqhc_grantees$address, " Frnt")

# concatenate address, city, and state 
fqhc_grantee_addresses <- str_c(fqhc_grantees$address, ", ", fqhc_grantees$city, ", ", fqhc_grantees$state, " ", fqhc_grantees$zip_code)

# apply geocode function
fqhc_grantee_addresses_geo <- geocode_OSM(fqhc_grantee_addresses)

# satellites next
# clean up address names 
fqhc_satellites$address <- str_remove(fqhc_satellites$address, " Ste .+")
fqhc_satellites$address <- str_remove(fqhc_satellites$address, " Bldg .+")
fqhc_satellites$address <- str_remove(fqhc_satellites$address, " Frnt")
fqhc_satellites$address <- str_remove(fqhc_satellites$address, " # .+")

# clean up specific errors in the data 

# concatenate address, city, and state 
fqhc_satellite_addresses <- str_c(fqhc_satellites$address, ", ", fqhc_satellites$city, ", ", fqhc_satellites$state, " ", fqhc_satellites$zip_code)

# remove duplicates
fqhc_satellite_addresses <- unique(fqhc_satellite_addresses)

# apply geocoding function 
fqhc_satellite_addresses_geo <- geocode_OSM(fqhc_satellite_addresses)

# convert to spatial feature 
fqhc_grantee_addresses_geo_points <- st_as_sf(fqhc_grantee_addresses_geo,
                                              coords = c(x = "lon", y = "lat"), 
                                              crs = "EPSG:4269")

fqhc_satellite_addresses_geo_points <- st_as_sf(fqhc_satellite_addresses_geo,
                                                coords = c(x = "lon", y = "lat"), 
                                                crs = "EPSG:4269")

# visualize to confirm
# but first, import tigris county shape files 
az_counties <- counties(state = "04")

# and save to disk 
write_rds(az_counties, "data/tidy/az_counties_sf.rds")

# now visualize 
ggplot() +
  geom_sf(data = az_counties, alpha = .1) +
  geom_sf(data = fqhc_grantee_addresses_geo_points, color = "blue", alpha = .3) +
  geom_sf(data = fqhc_satellite_addresses_geo_points, color = "red", alpha = .3)

# save spatial data to disk for use in ESRI ArcGIS
st_write(fqhc_grantee_addresses_geo_points, 
         "data/gis/fqhc_grantees/fqhc_grantees.shp",
         append = FALSE)

# save spatial data to disk for use in ESRI ArcGIS
st_write(fqhc_satellite_addresses_geo_points, 
         "data/gis/fqhc_satellites/fqhc_satellites.shp",
         append = FALSE)

