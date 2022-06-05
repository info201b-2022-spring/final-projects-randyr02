# Chart 3 
# Author: Vince Qian
# Exploratory Data Analysis INFO 201

## This chart attempts to display an interactive bar chart to show
## the total deaths over time.

# Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

# Create the bar chart function
get_bar <- function(df, area) {
  
  # Calculate the summaries of each month
  trend <- df %>%
    filter(location == area) %>%
    mutate(month = strftime(date, format = "%Y-%m")) %>%
    group_by(month) %>%
    summarise(monthly_total_deaths = max(total_deaths),
              monthly_new_deaths = mean(new_deaths_per_million))
  
  # Create the bar chart
  bar <- ggplot(data = trend) +
    geom_col(mapping = aes(x = month, y = monthly_total_deaths,
                           fill = monthly_new_deaths))+
    labs(x = "Month",
         y = "Total deaths",
         fill = "New deaths per million",
         title = paste(area, "Total Deaths over time")) +
    theme(axis.text.x = element_text(angle = 90)) +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_fill_gradient(low = "white", high = "black")
  
  # Make it interactive
  ggplotly(bar)
}