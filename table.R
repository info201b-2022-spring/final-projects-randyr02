# Aggregate table script
# Aliya Ali
# 05/16/22
# Group members: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian

#load the datasets and package.
library(tidyverse)
covid_data <- read.csv("owid-covid-data.csv")

#new dataset for the covid data that includes only needed columns
covid_dataset <- covid_data[c("iso_code", "location" ,"date","total_cases", "new_cases", "total_deaths", "new_deaths", "total_vaccinations")]

#new data set that is grouped by date and includes the average number of cases and deaths
grouped <- group_by(covid_dataset, date)
avg_values <- summarise(grouped, avg_cases = mean(total_cases, na.rm = TRUE), avg_deaths = mean(total_deaths, na.rm = TRUE))

#value of every 4 months to report in .rmd file 
# at different locations
library(lubridate)
sum_4months_report <- covid_dataset %>%
  mutate(date = as.Date(date, format = "%Y-%m-%d")) %>%
  arrange(date) %>%
  group_by(location, start_date = floor_date(date, "4 months")) %>%
  summarise(value = na.omit(sum(total_cases)))

# `rmd.report` reports the total number of cases around the 
# world every 4 months with the start date in the `start_date` 
# column
rmd_report <- sum_4months_report %>%
  group_by(start_date) %>%
  summarise(total_cases_in_4_months= sum(value))
