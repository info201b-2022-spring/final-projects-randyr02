library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")


# Load data frame
covid_data <- read.csv("owid-covid-data.csv")

# Get continent names
continents <- data.frame(unique(covid_data$continent[covid_data$continent != ""]))

# Get country names
countries <- data.frame(unique(covid_data$iso_code[covid_data$continent != ""]))

# Introduction page
introduction <- tabPanel(
  "Introduction",
  titlePanel("Final Deliverable"),
  h3("INFO 201 BE-1"),
  h3("Authors: Vince Qian, Aliya Ali, Kaia Truong, Randy Ros"),
  uiOutput('markdown')
)

# Chart 1 page
chart_1_page <- tabPanel(
  "Total Cases & Vaccinations Map",
  titlePanel("Total Cases & Vaccinations Map"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "radio_data",
        label = h4("Display Data By"),
        choiceNames = c("Total Cases", "Total Vaccinations"),
        choiceValues = c("cases", "vaccinations"),
        selected = "cases"
      )
    ),
    
    # Display bar graph in main panel
    mainPanel(
      h3("Total Cases & Vaccinations Map"),
      p("Some sentences"),
      plotlyOutput("map")
    )
  )
)

# Chart 2 page
chart_2_page <- tabPanel(
  "Deaths vs. Vaccinations Plot",
  titlePanel("Deaths vs. Vaccinations Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_plot",
                  label = h4("Select Continent"),
                  choices = list(
                    "Continent" = continents$unique.covid_data.continent.covid_data.continent........),
                  selected = "Asia")
    ),
    mainPanel(
      h3("Deaths vs. Vaccinations"),
      plotlyOutput("plot"),
      p("Some sentences")
    )
  )
)

chart_3_page <- tabPanel(
  "Total Deaths over time Bar Chart",
  titlePanel("Total Deaths over time Chart"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_bar",
                  label = h4("Select Location"),
                  choices = list(
                    "Country" = countries$unique.covid_data.iso_code.covid_data.continent........),
                  selected = "USA")
    ),
    mainPanel(
      h3("Total Deaths over time"),
      plotlyOutput("bar_graph"),
      p("Some sentences.")
    )
  )
)

# Conclusion page
conclusion <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion")
)


ui <- navbarPage(
  "Covid Cases and Vaccinations",
  theme = shinytheme("flatly"),
  introduction,
  chart_1_page,
  chart_2_page,
  chart_3_page,
  conclusion
)
