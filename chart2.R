# Chart 2 
# Author: Vince Qian
# Exploratory Data Analysis INFO 201

## This chart attempts to display an interactive scatter plot to show
## the relationship between total vaccinations and total deaths
## of all countries/locations.

# Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

covid_data <- read.csv("owid-covid-data.csv")
# Create the scatter plot function
get_scatter <- function(df, continent_name = "World") {

  # Remove NAs and non-location observations, and get the latest data
  if (continent_name == "World") {
    latest_data <- df %>%
      filter(!is.na(total_deaths)) %>%
      filter(!is.na(total_vaccinations)) %>%
      filter(!is.na(population)) %>%
      filter(continent == "Africa" | continent == "Asia" |
               continent == "Europe" | continent == "North America" |
               continent == "Oceania" | continent == "South America") %>%
      group_by(iso_code) %>%
      filter(date == max(date)) %>%
      mutate(vaccination_rate = round(total_vaccinations/population,4),
             death_rate = round(total_deaths/population,4))
  } else {
    latest_data <- df %>%
      filter(!is.na(total_deaths)) %>%
      filter(!is.na(total_vaccinations)) %>%
      filter(!is.na(population)) %>%
      filter(continent == continent_name) %>%
      group_by(iso_code) %>%
      filter(date == max(date)) %>%
      mutate(vaccination_rate = round(total_vaccinations/population,4),
           death_rate = round(total_deaths/population,4))
  }
  
  
  # Create the scatter plot
  scatter <- ggplot(data = latest_data) +
    geom_point(mapping = aes(x = vaccination_rate,
                             y = death_rate,
                             color = continent,
                             text = paste("country:", location, "<br>", 
                                          "updated:", date))
    ) +
    labs(
      x = "Vaccination rate",
      y = "Death rate",
      title = "Death rate vs. Vaccination rate")
  
  # Make it interactive
  ggplotly(scatter)
}

get_scatter(covid_data)