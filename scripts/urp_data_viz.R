# underrepresented populations
# University of Arizona Cancer Center
# Rene Dario Herrera
# renedarioherrera at email dot arizona dot edu 
# 17 August 2021

# set up ####
# packages 
library(here)
library(tidyverse)
library(ggthemes)

# call data tidy script
source("scripts/urp_tidy.R")

# theme ####
# set consistent theme for graphics & data visualizations
theme_uazcc_brand <- theme_clean(base_size = 16) +
  theme(
    text = element_text(
      family = "sans",
      # face = "bold",
      color = "#001C48",
      # size = rel(1.5)
    ),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_line(color = "#1E5288"),
    plot.background = element_rect(fill = "#EcE9EB"),
    aspect.ratio = 9 / 16,
    legend.background = element_rect(fill = "white"),
    legend.position = "right",
    plot.caption = element_text(size = 8),
    # plot.subtitle = element_text(size = 12),
    # plot.title = element_text(size = 14),
    strip.background = element_rect(fill = "#EcE9EB")
  )

# clinical patient volume by sex #### 
# data table 
patient_volume %>%
  filter(group == "sex") %>%
  pivot_wider(names_from = "year",
              values_from = "estimate") %>%
  write_csv("figures/tables/patient_volume_by_sex.csv")

# plot
patient_volume %>%
  filter(group == "sex") %>%
  ggplot(mapping = aes(x = year, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Clinical Patient Volume",
       subtitle = "by Sex",
       x = "Year",
       y = "Number of Patients",
       fill = "Sex") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_clinical_patient_volume_by_sex.png",
       width = 16,
       height = 9)

# clinical patient volume by ethnicity #### 
# data table 
patient_volume %>%
  filter(group == "ethnicity") %>%
  pivot_wider(names_from = "year",
              values_from = "estimate") %>%
  write_csv("figures/tables/patient_volume_by_ethnicity.csv")

# plot
patient_volume %>%
  filter(group == "ethnicity") %>%
  ggplot(mapping = aes(x = year, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Clinical Patient Volume",
       subtitle = "by Ethnicity",
       x = "Year",
       y = "Number of Patients",
       fill = "Ethnicity") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_clinical_patient_volume_by_ethnicity.png",
       width = 16,
       height = 9)

# clinical patient volume by race #### 
# data table 
patient_volume %>%
  filter(group == "race") %>%
  pivot_wider(names_from = "year",
              values_from = "estimate") %>%
  write_csv("figures/tables/patient_volume_by_race.csv")

# plot
patient_volume %>%
  filter(group == "race") %>%
  ggplot(mapping = aes(x = year, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Clinical Patient Volume",
       subtitle = "by Race",
       x = "Year",
       y = "Number of Patients",
       fill = "Race") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_clinical_patient_volume_by_race.png",
       width = 16,
       height = 9)

# clinical patient volume by age #### 
# data table 
patient_volume %>%
  filter(group == "age") %>%
  pivot_wider(names_from = "year",
              values_from = "estimate") %>%
  write_csv("figures/tables/patient_volume_by_age.csv")

# plot
patient_volume %>%
  filter(group == "age") %>%
  ggplot(mapping = aes(x = year, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Clinical Patient Volume",
       subtitle = "by Age",
       x = "Year",
       y = "Number of Patients",
       fill = "Age") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_clinical_patient_volume_by_age.png",
       width = 16,
       height = 9)

# new cases by gender #### 
# table
new_cases %>%
  filter(group == "gender") %>%
  pivot_wider(names_from = "ana",
              values_from = "estimate") %>%
  write_csv("figures/tables/new_cases_by_gender.csv")

# plot
new_cases %>%
  filter(group == "gender") %>%
  ggplot(mapping = aes(x = ana, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Banner University Cancer Center",
       subtitle = "New Cases in Calendar Year 2020",
       x = "ANA",
       y = "Number of Patients",
       fill = "Sex") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_new_cases_by_sex.png",
       width = 16,
       height = 9)

# new cases by ethnicity #### 
# table
new_cases %>%
  filter(group == "ethnicity") %>%
  pivot_wider(names_from = "ana",
              values_from = "estimate") %>%
  write_csv("figures/tables/new_cases_by_ethnicity.csv")

# plot
new_cases %>%
  filter(group == "ethnicity") %>%
  ggplot(mapping = aes(x = ana, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Banner University Cancer Center",
       subtitle = "New Cases in Calendar Year 2020",
       x = "ANA",
       y = "Number of Patients",
       fill = "Ethnicity") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_new_cases_by_ethnicity.png",
       width = 16,
       height = 9)

# new cases by race #### 
# table
new_cases %>%
  filter(group == "race") %>%
  pivot_wider(names_from = "ana",
              values_from = "estimate") %>%
  write_csv("figures/tables/new_cases_by_race.csv")

# plot
new_cases %>%
  filter(group == "race") %>%
  ggplot(mapping = aes(x = ana, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Banner University Cancer Center",
       subtitle = "New Cases in Calendar Year 2020",
       x = "ANA",
       y = "Number of Patients",
       fill = "Race") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_new_cases_by_race.png",
       width = 16,
       height = 9)

# new cases by age #### 
# table
new_cases %>%
  filter(group == "age") %>%
  pivot_wider(names_from = "ana",
              values_from = "estimate") %>%
  write_csv("figures/tables/new_cases_by_age.csv")

# plot
new_cases %>%
  filter(group == "age") %>%
  ggplot(mapping = aes(x = ana, y = estimate, group = variable)) +
  geom_col(mapping = aes(fill = variable), position = "dodge") +
  labs(title = "Banner University Cancer Center",
       subtitle = "New Cases in Calendar Year 2020",
       x = "ANA",
       y = "Number of Patients",
       fill = "Age") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/urp_new_cases_by_age.png",
       width = 16,
       height = 9)

# accrual by age ####
# table
accrual_by_age %>%
  pivot_wider(names_from = c("age", "year"),
              values_from = "estimate") %>%
  write_csv("figures/tables/accrual_by_age.csv")

# plot 
accrual_by_age %>%
  #mutate(year = as.numeric(year)) %>%
  ggplot(mapping = aes(x = year, y = estimate, group = site)) +
  geom_line(mapping = aes(color = site)) +
  facet_wrap(~age) +
  labs(title = "Treatment Accrual by Age Group",
       subtitle = "",
       x = "Site",
       y = "Number of Patients",
       color = "Age") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/accrual_by_age.png",
       width = 16,
       height = 9)

# accrual by ethnicity ####
# table
accrual_by_eth %>%
  pivot_wider(names_from = c("ethnicity", "year"),
              values_from = "estimate") %>%
  write_csv("figures/tables/accrual_by_ethnicity.csv")

# plot 
accrual_by_eth %>%
#  mutate(year = as.numeric(year)) %>%
  ggplot(mapping = aes(x = year, y = estimate, group = site)) +
  geom_line(mapping = aes(color = site)) +
  facet_wrap(~ethnicity) +
  labs(title = "Treatment Accrual by Ethnicity",
       subtitle = "",
       x = "Site",
       y = "Number of Patients",
       color = "Ethnicity") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/accrual_by_ethnicity.png",
       width = 16,
       height = 9)

# accrual by race ####
# table
accrual_by_race %>%
  pivot_wider(names_from = c("race", "year"),
              values_from = "estimate") %>%
  write_csv("figures/tables/accrual_by_race.csv")

# plot 
accrual_by_race %>%
  #  mutate(year = as.numeric(year)) %>%
  ggplot(mapping = aes(x = year, y = estimate, group = site)) +
  geom_line(mapping = aes(color = site)) +
  facet_wrap(~race) +
  labs(title = "Treatment Accrual by Race",
       subtitle = "",
       x = "Site",
       y = "Number of Patients",
       color = "Race") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/accrual_by_race.png",
       width = 16,
       height = 9)

# accrual by sex ####
# table
accrual_by_sex %>%
  pivot_wider(names_from = c("sex", "year"),
              values_from = "estimate") %>%
  write_csv("figures/tables/accrual_by_sex.csv")

# plot 
accrual_by_sex %>%
  #  mutate(year = as.numeric(year)) %>%
  ggplot(mapping = aes(x = year, y = estimate, group = site)) +
  geom_line(mapping = aes(color = site)) +
  facet_wrap(~sex) +
  labs(title = "Treatment Accrual by Sex",
       subtitle = "",
       x = "Site",
       y = "Number of Patients",
       color = "Sex") +
  scale_fill_brewer(palette = "Set1") +
  theme_uazcc_brand

ggsave(filename = "figures/charts/accrual_by_sex.png",
       width = 16,
       height = 9)
