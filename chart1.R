library(dplyr)
library(htmltools)
library(plotly)

covid_data <- read.csv("owid-covid-data.csv")

get_map <- function(df, input) {
  
  latest_data <- df %>%
    filter(date == max(date)) %>%
    filter(location != "World") %>%
    filter(iso_code != "")
  
  #boundaries
  l <- list(color = toRGB("grey"), width = 0.5)
  
  #map projection
  g <- list(
    projection = list(type = "Mercator")
  )
  
  #text
  hover_text <- paste("Country:",
                      latest_data$location, "<br>",
                      "Total cases:",
                      latest_data$total_cases,
                      "<br>", "Total vaccinations:",
                      latest_data$total_vaccinations)
  
  #create map
  if (input == "cases") {
    chloropleth_map <- plot_geo(latest_data) %>%
      add_trace(
        hoverinfo = "text", z = ~total_cases, color = ~total_cases,
        text = hover_text, locations = ~iso_code,
        zmin=0,
        zmax=30000000,
        marker = list(line = l)
      ) %>%
      colorbar(title = "Total cases") %>%
      layout(geo = g)
    
    #return
    chloropleth_map
  } else {
    chloropleth_map <- plot_geo(latest_data) %>%
      add_trace(
        hoverinfo = "text", z = ~total_vaccinations, color = ~total_vaccinations,
        text = hover_text, locations = ~iso_code,
        zmin=0,
        zmax=500000000,
        marker = list(line = l)
      ) %>%
      colorbar(title = "Total vaccinations") %>%
      layout(geo = g)
    
    #return map
    chloropleth_map
  }
}

get_map(covid_data, "cases")
get_map(covid_data, "vaccinations")