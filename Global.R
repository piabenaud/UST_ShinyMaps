
# Title:      UST3 Shiny App Map - The messy part
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Load packages -----------------------------------------------------------

library(dplyr)
library(readr)
library(rgdal) # for reading shp files because I couldn't get sf to install...


# Import table with site info ---------------------------------------------

#delivery <- read_csv()

# Import catchment shapefiles ---------------------------------------------

Schemes_shp <- readOGR("Data/Catchments/", "New_DrWPA_Catchments")

Investigations_shp <- readOGR("Data/Catchments/", "New_DrWPA_Investigations")

BAU_shp <- readOGR("Data/Catchments/", "BAU_UST3_Catchments")



# Options for colours -----------------------------------------------------

# This links the options in the drop-downs with the cols in the df
vars <- c("Catchment Lead" = "Catchment_Lead",
          "Catchment Category" = "Catchment_Category") #etc