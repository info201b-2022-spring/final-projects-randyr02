# app.R
# Authors: Kaia Truong, Aliya Ali, Randy Ros, Vince Qian
# Final Deliverable INFO 201

# Load library
library("shiny")

# Source ui and server of the app
source("ui.R")
source("server.R")

# Run the app
shinyApp(ui = ui, server = server)