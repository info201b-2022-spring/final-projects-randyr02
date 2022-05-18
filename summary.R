#Summary file 
# Author: Kaia Truong
# Created on 05/ 14/ 2022
# Exploratory Data Analysis INFO201
# Group members: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian
library(tidyverse)

# Load dataset. Please download the dataset locally to 
# your computer and fix the read.csv line by editting the
# file directory
# Dataset to use: 
#   Covid vaccination: https://www.kaggle.com/datasets/rsrishav/covid-vaccination-dataset?select=vaccinations.csv
#   Covid cases and death: https://www.kaggle.com/datasets/georgesaavedra/covid19-dataset

# After downloading the dataset, the two dataset are read
# as below
covid_data <- read.csv("owid-covid-data.csv")

# A function that takes in `covid_data` dataset and returns a list 
# of info about it:
summary_data_info <- list() 

summary_data_info$num_observations <- nrow(covid_data)

summary_data_info$num_features <- ncol(covid_data)

summary_data_info$world_total_deaths <- covid_data %>%
  filter(total_deaths == max(total_deaths, na.rm = T)) %>%
  select(location, total_deaths, date) 

summary_data_info$world_total_cases <- covid_data %>%
  filter(total_cases == max(total_cases, na.rm = T)) %>%
  select(location, total_cases, date) 

summary_data_info$world_total_tests <- covid_data %>%
  filter(total_tests == max(total_tests, na.rm = T)) %>%
  select(location, total_tests, date) 

summary_data_info$total_vaccinations <- covid_data %>%
  filter(total_vaccinations == max(total_vaccinations, na.rm = T)) %>%
  select(location, total_vaccinations, date) 

sub_data_df <- covid_data[!(covid_data$location == "World" | covid_data$location =="High income" | covid_data$location =="Upper middle income"), ] 

summary_data_info$location_max_deaths <- sub_data_df %>%
  filter(total_deaths == max(total_deaths, na.rm = T)) %>%
  select(location, total_deaths, date) 

summary_data_info$location_max_cases <- sub_data_df %>%
  filter(total_cases == max(total_cases, na.rm = T)) %>%
  select(location, total_cases, date) 



