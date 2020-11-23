# UST_ShinyMaps
Having trouble keeping up with where we're working? There's an app for that!

This is a really basic map, so please let me know any suggestions for things I can add to make it better...

Current list:
Include WTW information - can someone please add this to the "Catchment Details" csv in data?
Include monitoring location markers with details - to be added as and when, will need a csv with x and y coords for locations and any relevant info

To run the app locally, please run the following in your R console: 
```R
library(shiny)
runGitHub( "UST_ShinyMaps", "piabenaud", ref = "main")
```
To do this you will need the following packages, which can be installed by running this code in your R console:
 ```R
 install.packages(c("shiny", "leaflet", "dplyr", "readr", "rgdal", "lubridate", "ggplot2"))
 ```
