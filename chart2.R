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
      filter(!is.na(new_vaccinations_smoothed_per_million)) %>%
      filter(!is.na(new_deaths_smoothed_per_million)) %>%
      filter(continent == "Africa" | continent == "Asia" |
               continent == "Europe" | continent == "North America" |
               continent == "Oceania" | continent == "South America") %>%
      group_by(iso_code) %>%
      filter(date == max(date))
  } else {
    latest_data <- df %>%
      filter(!is.na(new_vaccinations_smoothed_per_million)) %>%
      filter(!is.na(new_deaths_smoothed_per_million)) %>%
      filter(continent == continent_name) %>%
      group_by(iso_code) %>%
      filter(date == max(date))
  }
  
  
  # Create the scatter plot
  scatter <- ggplot(data = latest_data) +
    geom_point(mapping = aes(x = new_vaccinations_smoothed_per_million,
                             y = new_deaths_smoothed_per_million,
                             color = continent,
                             text = paste("country:", location, "<br>", 
                                          "updated:", date))
    ) +
    labs(
      x = "New Vaccinations per million",
      y = "New Deaths per million",
      title = "New Deaths vs New Vaccinations")
  
  # Make it interactive
  ggplotly(scatter)
}

get_scatter(covid_data)