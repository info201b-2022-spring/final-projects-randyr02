library(dplyr)
library(htmltools)
library(plotly)

covid_data <- read.csv("owid-covid-data.csv")

get_map <- function(df, input) {
  
  latest_data <- df %>%
    filter(!is.na(total_vaccinations)) %>%
    group_by(iso_code) %>%
    filter(date == max(date))
  
  #boundaries
  l <- list(color = toRGB("grey"), width = 0.5)
  
  #map projection
  g <- list(
    projection = list(type = "Mercator")
  )
  
  #text
  text <- paste(latest_data$location, "<br>",
                      "Total cases:",
                      latest_data$total_cases, "<br>",
                      "Total vaccinations:",
                      latest_data$total_vaccinations, "<br>",
                      "Last updated:", latest_data$date)
  
  #create map
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
    
    #return
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
    
    #return
    map
  }
}

get_map(covid_data, "cases")
get_map(covid_data, "vaccinations")