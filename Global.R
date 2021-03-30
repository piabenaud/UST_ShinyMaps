

# Title:      UST3 Shiny App Map - The messy part
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Load packages -----------------------------------------------------------

library(dplyr)
library(forcats) # for leveling factor data
library(readr)
library(purrr)
library(raster) # for reading shp files and bind function
library(lubridate)
library(sp) # for the csv spatial data 


# Import table with site info ---------------------------------------------

Delivery <- read_csv("Data/Catchment_details.csv")

Delivery <- Delivery %>% 
  mutate('Project_Start'= dmy(Project_Start),
         'Project_End' = dmy(Project_End)) # convert date time to useful format 


# Import catchment shapefiles ---------------------------------------------

Schemes_shp <- shapefile("Data/Catchments/New_DrWPA_Catchments.shp")
Schemes_shp <- spTransform(Schemes_shp, CRS("+init=epsg:4326")) # transform from bng to wsg84 as leaftlet basemaps are in that projection

Investigations_shp <- shapefile("Data/Catchments/New_DrWPA_Investigations.shp")
Investigations_shp <- spTransform(Investigations_shp, CRS("+init=epsg:4326"))

BAU_shp <- shapefile("Data/Catchments/BAU_UST3_Catchments.shp")
BAU_shp <- spTransform(BAU_shp, CRS("+init=epsg:4326"))


# Merge shapefiles into one -----------------------------------------------

Catchments <- bind(Schemes_shp, Investigations_shp)


# Let's bring together the shapefiles and dataframe -----------------------

Catchments <- merge(Catchments, Delivery, by.x ="WB_NAME", by.y = "Name")

BAU <- merge(BAU_shp, Delivery, by.x = "Catchment", by.y = "Name")


# Options for colours -----------------------------------------------------

# This links the options in the drop-downs with the cols in the df
catchment_vars <- c("Catchment Type" = "Type", 
          "Catchment Lead" = "Lead",
          "Catchment Group" = "Group") 

monitoring_vars <- c("All" = "Default", 
                    "Sondes" = "Sonde",
                    "Pump Samplers" = "Pump",
                    "Spot Sampling" = "Spot",
                    "Flow" = "Flow",
                    "Stage" = "Stage")

# Today's date for vline on plot -------------------------------------------

today <- lubridate::now(tzone = "UTC")


# CSV BNG to WGS84 transformation function --------------------------------------

df_bng_wgs84 <- function(.data, .easting, .northing){
  
  easting <- sym(.easting)
  northing <- sym(.northing)
  
  BNG <- "+init=epsg:27700" # BNG
  wgs84 <- "+init=epsg:4326" # WGS84
  
  .data %>% 
    dplyr::select(easting, northing) %>% 
    SpatialPointsDataFrame(., data = .data, proj4string = CRS(BNG)) %>% 
    spTransform(., CRS(wgs84))
  
}


# Import and Transform Monitoring Locs ------------------------------------------

Locations <- read_csv("Data/UST3_Monitoring_Locations.csv")

Locations <- Locations %>% # ordering factors of option so colour pal consistent
  mutate(Sonde = Sonde %>% forcats::fct_relevel("Yes", "Maybe", "No"),
         Spot = Spot %>% forcats::fct_relevel("Yes", "No"),
         Pump = Pump %>% forcats::fct_relevel("Yes", "No"),
         Flow = Flow %>% forcats::fct_relevel("Yes", "No"),
         Stage = Stage %>% forcats::fct_relevel("Yes", "No"))


Locations <- df_bng_wgs84(Locations, .easting = "Easting", .northing = "Northing") 


# Import and Transform Tavy csv -------------------------------------------------

Tavy_locs_BNG <- read_csv("Data/Tavy_PotentialMonitoringSites.csv")

Tavy_locs <- df_bng_wgs84(Tavy_locs_BNG, .easting = "Easting", .northing = "Northing")

rm(Tavy_locs_BNG) # keep things tidy


# Import and tidy EA data -------------------------------------------------------

# EA_spot_BNG <- readRDS("Data/EA_spot.rds")
# 
# EA_tidy <- function(.data){
# 
#     .data %>%
#     group_by(location, determinand, easting, northing) %>%
#     filter(determinand %in% c("C - Org Filt",
#                               "CHLOROPHYLL",
#                               "Phosphorus-P",
#                               "Nitrate-N",
#                               "Nitrite-N",
#                               "Nitrogen - N",
#                               "TurbidityNTU",
#                               "NH3 un-ion",
#                               "Potassium- K",
#                               "Ammonia(N)",
#                               "Temp Water",
#                               "Mn- Filtered",
#                               "Colour Filt"))
# }
# 
# EA_spot_BNG <- EA_spot_BNG %>%
#   map(., ~EA_tidy(.))


# SpatialPoints DF of EA_spot in WSG84 ------------------------------------------

# EA_spot_locs <- EA_spot_BNG %>% 
#   map(., ~group_by(., location, determinand, easting, northing) %>% 
#         dplyr::summarise(n = n()) %>% 
#         filter(n >= 10) %>% # locations with more than 10 samples
#         ungroup(.) %>% 
#         dplyr::select(location, easting, northing) %>% 
#         distinct(location, .keep_all = TRUE)) %>% # pull out list just of sampled locations
#   map(., ~df_bng_wgs84(., "easting", "northing"))  # note: must ungroup to work!!!
# 

# List of plots for EA spot -----------------------------------------------------

 # plot function

# 
# 
# 
# 
# 
# 
# EA_spot_locs <- EA_spot_BNG %>% 
#   map(., ~group_by(., location, determinand, easting, northing) %>% 
#         dplyr::summarise(n = n()) %>% 
#         filter(n >= 10) 
#       
# 
# 
# 
# 
# rm(EA_spot_BNG) # keep things tidy


