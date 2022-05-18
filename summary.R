#Summary file 
# Author: Kaia Truong
# Created on 05/ 14/ 2022
# Exploratory Data Analysis INFO201
# Group members: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian
library(tidyverse)
library(stringr)

# Load dataset. Please download the dataset locally to 
# your computer and fix the read.csv line by editting the
# file directory
# Dataset to use: 
#   Covid vaccination: https://www.kaggle.com/datasets/rsrishav/covid-vaccination-dataset?select=vaccinations.csv
#   Covid cases and death: https://www.kaggle.com/datasets/georgesaavedra/covid19-dataset

# After downloading the dataset, the two dataset are read
# as below
covid_vaccination <- read.csv("vaccinations.csv")
covid_data <- read.csv("owid-covid-data.csv")

# A function that takes in `covid_vaccination` dataset and returns a list 
# of info about it:
summary_vaccinations_info <- list() 

summary_vaccinations_info$num_observations <- nrow(covid_vaccination)

summary_vaccinations_info$num_features <- ncol(covid_vaccination)

summary_vaccinations_info$world_total_vaccinations <- covid_vaccination %>%
  filter(total_vaccinations == max(total_vaccinations, na.rm = T)) %>%
  select(location, total_vaccinations) 

summary_vaccinations_info$number_of_people_fully_vaccinated <- covid_vaccination %>%
  filter(people_fully_vaccinated == max(people_fully_vaccinated, na.rm = T)) %>%
  select(location, people_fully_vaccinated) 

sub_vaccination_df <- covid_vaccination[!(covid_vaccination$location == "World" | covid_vaccination$location =="High income" | covid_vaccination$location =="Upper middle income"), ] 

summary_vaccinations_info$continent_highest_total_vaccinations <- sub_vaccination_df %>%
  filter(total_vaccinations == max(total_vaccinations, na.rm = T)) %>%
  select(location, total_vaccinations) 

summary_vaccinations_info$continent_most_people_vaccinated <- sub_vaccination_df %>%
  filter(people_fully_vaccinated == max(people_fully_vaccinated, na.rm = T)) %>%
  select(location, people_fully_vaccinated) 


# A function that takes in `covid_data` dataset and returns a list 
# of info about it:
summary_data_info <- list() 

summary_data_info$num_observations <- nrow(covid_data)

summary_data_info$num_features <- ncol(covid_data)

summary_data_info$world_total_deaths <- covid_data %>%
  filter(total_deaths == max(total_deaths, na.rm = T)) %>%
  select(location, total_deaths) 

summary_data_info$world_total_cases <- covid_data %>%
  filter(total_cases == max(total_cases, na.rm = T)) %>%
  select(location, total_cases) 

sub_data_df <- covid_data[!(covid_data$location == "World" | covid_data$location =="High income" | covid_data$location =="Upper middle income"), ] 

summary_data_info$location_max_deaths <- sub_data_df %>%
  filter(total_deaths == max(total_deaths, na.rm = T)) %>%
  select(location, total_deaths) 

summary_data_info$location_max_cases <- sub_data_df %>%
  filter(total_cases == max(total_cases, na.rm = T)) %>%
  select(location, total_cases) 


