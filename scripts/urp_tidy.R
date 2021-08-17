# underrepresented populations
# University of Arizona Cancer Center
# Rene Dario Herrera
# renedarioherrera at email dot arizona dot edu 
# 17 August 2021

# set up ####
# packages 
library(here)
library(tidyverse)

# read data accrual #### 
# treatment accrual by age 
accrual_by_age <- read_csv("data/raw/urp_trx_accrual_data_by_age.csv",
                           col_types = list(
                             site = col_character(),
                             age = col_factor(levels = c("<21", "21-64", "65+", "Unknown")),
                             year = col_character(),
                             estimate = col_number())) %>%
  mutate(estimate = if_else(is.na(estimate), 0, estimate))

# inspect
glimpse(accrual_by_age)

# treatment accrual by ethnicity
accrual_by_eth <- read_csv("data/raw/urp_trx_accrual_data_by_ethnicity.csv",
                           col_types = list(
                             site = col_character(),
                             ethnicity = col_factor(levels = c("Hispanic", "Non-Hispanic", "Unknown")),
                             year = col_character(),
                             estimate = col_number())) %>%
  mutate(estimate = if_else(is.na(estimate), 0, estimate))

# inspect
glimpse(accrual_by_eth)

# treatment accrual by race
accrual_by_race <- read_csv("data/raw/urp_trx_accrual_data_by_race.csv",
                           col_types = list(
                             site = col_character(),
                             race = col_factor(levels = c("AI/AN", "Asian", "Black/AA", "NH/OPI", "White", "Unknown")),
                             year = col_character(),
                             estimate = col_number())) %>%
  mutate(estimate = if_else(is.na(estimate), 0, estimate))

# inspect
glimpse(accrual_by_race)

# treatment accrual by sex
accrual_by_sex <- read_csv("data/raw/urp_trx_accrual_data_by_sex.csv",
                            col_types = list(
                              site = col_character(),
                              sex = col_factor(levels = c("F", "M")),
                              year = col_character(),
                              estimate = col_number())) %>%
  mutate(estimate = if_else(is.na(estimate), 0, estimate))

# inspect
glimpse(accrual_by_sex)

# read data clinical patient volumes #### 
patient_volume <- read_csv("data/raw/urp_clinical_patient_volumes.csv",
                           col_types = list(
                             group = col_factor(levels = c("sex", "ethnicity", "race", "age")),
                             variable = col_character(),
                             year = col_character(),
                             estimate = col_number()
                           )) %>%
  mutate(estimate = if_else(is.na(estimate), 0, estimate))

# inspect
glimpse(patient_volume)

# read data new cancer cases #### 
new_cases <- read_csv("data/raw/urp_new_cancer_cases.csv",
                      col_types = list(
                        group = col_factor(levels = c("gender", "ethnicity", "race", "age")),
                        variable = col_character(),
                        ana = col_number(),
                        non_ana = col_number()
                      )) 

new_cases <- new_cases %>%
  pivot_longer(cols = c("ana", "non_ana"),
               names_to = "ana",
               values_to = "estimate") %>%
  mutate(ana = as_factor(ana))

# inspect
glimpse(new_cases)
