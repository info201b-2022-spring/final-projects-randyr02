# Aggregate table script
# Aliya Ali
# 05/16/22
# Group members: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian

#load the datasets and package.
library(tidyverse)
covid_vaccination <- read.csv("/Users/aliyaali/final-projects-randyr02/vaccinations.csv")
covid_data <- read.csv("/Users/aliyaali/final-projects-randyr02/owid-covid-data.csv")

#new dataset for the covid data that includes only needed columns
covid_dataset <- covid_data[c("location" ,"date","total_cases", "new_cases", "total_deaths", "new_deaths", "total_vaccinations")]

#new dataset for the vaccination data that includes only needed columns
vaccination_dataset <- covid_vaccination[c("location", "date", "total_vaccinations", "people_vaccinated", "people_fully_vaccinated", "total_boosters")]

#combined dataset of both dataframes
covid <- left_join(covid_dataset, vaccination_dataset, by = "date")

#new data set that is grouped by date and includes the average number of cases and deaths
grouped <- group_by(covid, date)
avg_values <- summarise(grouped, avg_cases = mean(total_cases, na.rm = TRUE), avg_deaths = mean(total_deaths, na.rm = TRUE))