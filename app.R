
# Title:      UST3 Shiny App Map - The App
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020

rm(list = ls())

# Packages ----------------------------------------------------------------

library(shiny)
library(leaflet)
library(ggplot2)


# Run global script -------------------------------------------------------

source("Global.R")


# The User Interface ------------------------------------------------------

ui <- navbarPage("Upstream Thinking 3: UoE Monitoring Catchment", id = 'nav',
                 tabPanel("The Map", source("Map_UI.R", local = TRUE)))


# The Server --------------------------------------------------------------

server <- function(input, output, session){
  source("Map_Server.R", local = TRUE)
}


# Run the App! ------------------------------------------------------------

shinyApp(ui = ui, server = server)
