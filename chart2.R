library("dplyr")
library("ggplot2")
library("plotly")

covid_data <- read.csv("owid-covid-data.csv")

get_scatter <- function(df) {

  latest_data <- df %>%
    filter(!is.na(total_vaccinations_per_hundred)) %>%
    filter(!is.na(total_deaths_per_million)) %>%
    filter(continent == "Africa" | continent == "Asia" |
           continent == "Europe" | continent == "North America" |
           continent == "Oceania" | continent == "South America") %>%
    group_by(iso_code) %>%
    filter(date == max(date))
  
  scatter <- ggplot(data = latest_data) +
    geom_point(mapping = aes(x = total_vaccinations_per_hundred,
                             y = total_deaths_per_million,
                             color = continent,
                             text = paste("country:", location))
    ) +
    labs(
      x = "Total Vaccinations per hundred",
      y = "Total Deaths per million")
  
  ggplotly(scatter)
}

get_scatter(covid_data)