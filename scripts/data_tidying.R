# 
# René Dario Herrera 
# The University of Arizona Cancer Center 
# renedherrera at email dot arizona dot edu
# 30 August 2021 

# set up
# packages 
library(here)
library(tidyverse)
library(readxl)
library(zipcodeR)
# library(leaflet)
library(tigris)

#read data
patient_zip <- read_excel("data/raw/Copy of Compiled patient data v2.xlsx",
                          sheet = "AZ Patients",
                          skip = 1,
                          trim_ws = TRUE,
                          na = "") %>%
  janitor::clean_names()

# preview
glimpse(patient_zip)

# subset to orange grove
orange_grove <- patient_zip %>%
  select(count = count_1, 
         zipcode = zip_2) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "orange_grove")

# subset to uacc north
uazcc_north <- patient_zip %>%
  select(count = count_6, 
         zipcode = zip_7) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "uazcc_north")

# subset to pediatric
pediatric <- patient_zip %>%
  select(count = number_of_patients, 
         zipcode = zip_code) %>%
  mutate(zipcode = as.character(zipcode)) %>%
  drop_na() %>%
  mutate(id = "pediatric")

az_patients <- orange_grove %>%
  full_join(uazcc_north) %>%
  full_join(pediatric) %>% 
  #filter(count >= 10) %>% #filter out low counts for privacy
  group_by(id) 

# inspect
class(az_patients)
az_patients
glimpse(az_patients)

# count of patient by clinic location 
az_patients %>%
  summarise(sum(count))

# count of patient by zip code 
az_patients %>%
  group_by(zipcode) %>%
  summarise(count = sum(count)) %>%
  arrange(desc(count))

# add data to describe the counties and zip codes 
zip_db <- zip_code_db

# add zip code data to uazcc patient data 
az_patients <- inner_join(
  x = az_patients, 
  y = zip_code_db, 
  by = "zipcode",
  keep = FALSE) %>%
  drop_na()

# add " County" to county
# az_patients <- az_patients %>%
#   mutate(county = paste(sep = " ", county, "County"))

# count of patient by AZ county
az_patients %>%
  ungroup() %>%
  group_by(county) %>%
  summarize(count = sum(count)) %>%
  arrange(desc(count))

# preview
glimpse(zip_db)

# save to disk
write_rds(az_patients, "data/tidy/uazcc_az_patients.rds")