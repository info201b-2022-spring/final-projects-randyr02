library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

covid_data <- read.csv("owid-covid-data.csv")

source("chart1.R")
source("chart2.R")
source("chart3.R")

# Define server function
server <- function(input, output) {
  
  ## Image on introduction page
  output$image <- renderUI({ 
    tags$img(src = "https://phil.cdc.gov//PHIL_Images/23311/23311_lores.jpg") 
    }) 

  ##Scatter plot
  output$plot <- renderPlotly({
    get_scatter(covid_data)
  })
  
  ##Map
  output$map <- renderPlotly({
    get_map(covid_data, input$radio_data)
  })
  
  ##Bar graph
  output$bar_graph <- renderPlotly({
    get_bar(covid_data, input$choose_country_bar)
  })
  
  
}