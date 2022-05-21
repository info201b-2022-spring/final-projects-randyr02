# Aggregate table script
# Aliya Ali
# 05/16/22
# Group members: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian

#load the datasets and package.
library(tidyverse)

covid_data <- read.csv("owid-covid-data.csv")

#new dataset for the covid data that includes only needed columns
covid_dataset <- covid_data[c("iso_code", "location" ,"date","total_cases", "new_cases", "total_deaths", "new_deaths", "total_vaccinations")]

# Filters all places that are not countries
sub_data_df <- covid_data %>% filter(str_detect(location, "World") == FALSE) %>%
  filter(str_detect(location, "income") == FALSE) %>%
  filter(str_detect(iso_code, "OWID_") == FALSE) %>%
  filter(location != continent)

#new data set that is grouped by date and includes the average number of cases and deaths
grouped <- group_by(sub_data_df, date)
avg_values <- summarise(grouped, avg_cases = mean(total_cases, na.rm = TRUE), avg_deaths = mean(total_deaths, na.rm = TRUE))

#value of every 4 months to report in .rmd file 
# at different locations
library(lubridate)
sum_4months_report <- sub_data_df %>%
  mutate(date = as.Date(date, format = "%Y-%m-%d")) %>%
  arrange(date) %>%
  group_by(location, start_date = floor_date(date, "4 months")) %>%
  summarise(value = na.omit(max(total_cases)))

# `rmd.report` reports the total number of cases around the 
# world every 4 months with the start date in the `start_date` 
# column
rmd_report <- sum_4months_report %>%
  group_by(start_date) %>%
  summarise(total_cases_in_4_months= max(value))
