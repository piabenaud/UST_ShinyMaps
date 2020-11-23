
# Title:      UST3 Shiny App Map - The messy part
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Load packages -----------------------------------------------------------

library(dplyr)
library(readr)
library(rgdal) # for reading shp files because I couldn't get sf to install...
#library(raster) # for binding shp files

# Import table with site info ---------------------------------------------

Delivery <- read_csv("Data/Catchment_details.csv")

# Import catchment shapefiles ---------------------------------------------

wgs84 <- "+init=epsg:4326" # Transform to WGS84 to work with basemap

Schemes_shp <- readOGR("Data/Catchments/", "New_DrWPA_Catchments")
Schemes_shp <- spTransform(Schemes_shp, CRS(wgs84))

Investigations_shp <- readOGR("Data/Catchments/", "New_DrWPA_Investigations")
Investigations_shp <- spTransform(Investigations_shp, CRS(wgs84))

#BAU_shp <- readOGR("Data/Catchments/", "BAU_UST3_Catchments")
#BAU_shp <- spTransform(BAU_shp, CRS(wgs84))
#BAU_shp <- merge(BAU_shp, Delivery, by.x = "Catchments", by.y = "Name")


# Merge shapefiles into one -----------------------------------------------

Catchments <- bind(Schemes_shp, Investigations_shp)

# need to add something to link together shapefiles and popups
# add wtw info

# Let's bring together the shapefiles and dataframe -----------------------

Catchments <- merge(Catchments, Delivery, by.x ="WB_NAME", by.y = "Name")


# Options for colours -----------------------------------------------------

# This links the options in the drop-downs with the cols in the df
vars <- c("Catchment Type" = "Type", 
          "Catchment Lead" = "Lead",
          "Catchment Group" = "Group") 

