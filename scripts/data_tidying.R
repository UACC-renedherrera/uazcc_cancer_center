# set up
# packages 
library(here)
library(tidyverse)
library(readxl)
library(zipcodeR)
library(leaflet)

#read data
patient_zip <- read_excel("data/raw/Copy of Compiled patient data v2.xlsx",
                          sheet = "AZ Patients",
                          skip = 1,
                          trim_ws = TRUE,
                          na = "")

# preview
glimpse(patient_zip)

# subset to orange grove
orange_grove <- patient_zip %>%
  select(count = `Count(*)...1`, 
         zipcode = `Zip...2`) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "orange_grove")

# subset to uacc north
uazcc_north <- patient_zip %>%
  select(count = `Count(*)...6`, 
         zipcode = `Zip...7`) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "uazcc_north")

# subset to pediatric
pediatric <- patient_zip %>%
  select(count = `Number of patients`, 
         zipcode = ZIP_CODE) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "pediatric")

az_patients <- orange_grove %>%
  full_join(uazcc_north) %>%
  full_join(pediatric) %>% 
  filter(count >= 10) %>% #filter out low counts for privacy
  group_by(id) 

az_patients %>%
  summarise(sum(count))

# prepare for mapping
zip_db <- zip_code_db

# preview
glimpse(zip_db)

# prepare for mapping
az_patients <- inner_join(az_patients, zip_code_db, by = "zipcode") %>%
  drop_na()

# save to disk
write_rds(az_patients, "data/tidy/uazcc_az_patients.rds")

# preview
glimpse(az_patients)

names(providers)

# generate map
leaflet(data = az_patients) %>%
  addProviderTiles(providers$Stamen.TonerBackground) %>%
  addMarkers(~lng, ~lat)
