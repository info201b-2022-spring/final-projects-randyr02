# server.R

# Load libraries
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

# Load data frame
covid_data <- read.csv("owid-covid-data.csv")

# Source charts
source("chart1.R")
source("chart2.R")
source("chart3.R")

# Define server function
server <- function(input, output) {
  
  ##Map
  output$map <- renderPlotly({
    get_map(covid_data, input$radio_data)
  })
  
  ##Scatter plot
  output$plot <- renderPlotly({
    get_scatter(covid_data, input$scatter_choice)
  })

  ##Bar graph
  output$bar_graph <- renderPlotly({
    get_bar(covid_data, input$bar_choice)
  })
  
}