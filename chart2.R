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

# Create the scatter plot function
get_scatter <- function(df) {

  # Remove NAs and non-location observations, and get the latest data
  latest_data <- df %>%
    filter(!is.na(total_vaccinations_per_hundred)) %>%
    filter(!is.na(total_deaths_per_million)) %>%
    filter(continent == "Africa" | continent == "Asia" |
           continent == "Europe" | continent == "North America" |
           continent == "Oceania" | continent == "South America") %>%
    group_by(iso_code) %>%
    filter(date == max(date))
  
  # Create the scatter plot
  scatter <- ggplot(data = latest_data) +
    geom_point(mapping = aes(x = total_vaccinations_per_hundred,
                             y = total_deaths_per_million,
                             color = continent,
                             text = paste("country:", location, "<br>", 
                                          "updated:", date))
    ) +
    labs(
      x = "Total Vaccinations per hundred",
      y = "Total Deaths per million",
      title = "Total Deaths vs Total Vaccinations")
  
  # Make it interactive
  ggplotly(scatter)
}