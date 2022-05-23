# Chart 1 
# Author: Vince Qian
# Exploratory Data Analysis INFO 201

## This chart attempts to display an interactive map to show
## the total COVID cases and vaccinations of all countries/locations.

# Load libraries
library(dplyr)
library(htmltools)
library(plotly)

# Create the map function
get_map <- function(df, input) {
  
  # Remove NAs and get the latest data
  latest_data <- df %>%
    filter(!is.na(total_vaccinations)) %>%
    group_by(iso_code) %>%
    filter(date == max(date))
  
  # Map boundaries setting
  l <- list(color = toRGB("grey"), width = 0.5)
  
  # Map projection setting
  g <- list(
    projection = list(type = "Mercator")
  )
  
  # Hover text setting
  text <- paste(latest_data$location, "<br>",
                      "Total cases:",
                      latest_data$total_cases, "<br>",
                      "Total vaccinations:",
                      latest_data$total_vaccinations, "<br>",
                      "Last updated:", latest_data$date)
  
  # Create the maps
  if (input == "cases") {
    map <- plot_geo(latest_data) %>%
      add_trace(
        hoverinfo = "text", z = ~total_cases, color = ~total_cases,
        text = text, locations = ~iso_code,
        zmin=0,
        zmax=30000000,
        marker = list(line = l)
      ) %>%
      colorbar(title = "Total cases") %>%
      layout(geo = g)
    
    # Return case map
    map
    
  } else {
    map <- plot_geo(latest_data) %>%
      add_trace(
        hoverinfo = "text", z = ~total_vaccinations, color = ~total_vaccinations,
        text = text, locations = ~iso_code,
        zmin=0,
        zmax=500000000,
        marker = list(line = l)
      ) %>%
      colorbar(title = "Total vaccinations") %>%
      layout(geo = g)
    
    # Return vaccination map
    map
    
  }
}

get_map(covid_data, "cases")
get_map(covid_data, "vaccinations")