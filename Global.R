
# Title:      UST3 Shiny App Map - The messy part
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Load packages -----------------------------------------------------------

library(dplyr)
library(readr)
library(raster) # for reading shp files bind function
library(lubridate)

# Import table with site info ---------------------------------------------

Delivery <- read_csv("Data/Catchment_details.csv")

Delivery <- Delivery %>% 
  mutate('Project_Start'= dmy(Project_Start),
         'Project_End' = dmy(Project_End)) # convert date time to useful format 

# add wtw info

# Import catchment shapefiles ---------------------------------------------

wgs84 <- "+init=epsg:4326" # Transform to WGS84 to work with basemap

Schemes_shp <- shapefile("Data/Catchments/New_DrWPA_Catchments.shp")
Schemes_shp <- spTransform(Schemes_shp, CRS(wgs84))

Investigations_shp <- shapefile("Data/Catchments/New_DrWPA_Investigations.shp")
Investigations_shp <- spTransform(Investigations_shp, CRS(wgs84))

BAU_shp <- shapefile("Data/Catchments/BAU_UST3_Catchments.shp")
BAU_shp <- spTransform(BAU_shp, CRS(wgs84))


# Merge shapefiles into one -----------------------------------------------

Catchments <- bind(Schemes_shp, Investigations_shp)


# Let's bring together the shapefiles and dataframe -----------------------

Catchments <- merge(Catchments, Delivery, by.x ="WB_NAME", by.y = "Name")


# Options for colours -----------------------------------------------------

# This links the options in the drop-downs with the cols in the df
vars <- c("Catchment Type" = "Type", 
          "Catchment Lead" = "Lead",
          "Catchment Group" = "Group") 


# Todays date for vline on plot -------------------------------------------

today <- lubridate::now(tzone = "UTC")
