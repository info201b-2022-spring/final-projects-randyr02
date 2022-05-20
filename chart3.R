library("dplyr")
library("ggplot2")
library("plotly")

get_bar <- function(df, area) {
  trend <- df %>%
    filter(iso_code == area) %>%
    mutate(month = strftime(date, format = "%Y-%m")) %>%
    group_by(month) %>%
    summarise(monthly_total_deaths = max(total_deaths),
              monthly_new_deaths = mean(new_deaths_per_million))
  
  country <- df %>%
    filter(iso_code == area) %>%
    filter(date == max(date)) %>%
    pull(location)
  
  bar <- ggplot(data = trend) +
    geom_col(mapping = aes(x = month, y = monthly_total_deaths,
                           fill = monthly_new_deaths))+
    labs(x = "Month",
         y = "Total deaths",
         fill = "New deaths per million",
         title = paste(country, "Total Deaths over time")) +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_fill_gradient(low = "white", high = "black")

    ggplotly(bar)
}

get_bar(covid_data, "OWID_WRL")