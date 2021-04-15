# UST_ShinyMaps
Having trouble keeping up with where we're working? There's an app for that!

This is a really basic map, so please let me know any suggestions for things I can add to make it better...

Current list:

* Include monitoring location markers with details - to be added as and when, will just need a csv with x and y coords for locations and any relevant info.
* Pop-up plots with EA monitoring data summaries based on determinand selected on the page

I'll get this running online properly once we're happy with it, but in the mean time, you can run it locally.

To run the app locally, please run the following in your R console: 
```R
library(shiny)
runGitHub( "UST_ShinyMaps", "piabenaud", ref = "main")
```
To do this you will need the following packages, which can be installed by running this code in your R console:
 ```R
 install.packages(c("shiny", "leaflet", "dplyr", "readr", "purrr" "raster", "lubridate", "ggplot2", "sp"))
 ```
To run the dev version (i.e. with the Tavy potential locations) use:
install.packages(c("shiny", "leaflet", "dplyr", "readr", "raster", "purrr', lubridate", "ggplot2", "forcats", "sp"))
library(shiny)
runGitHub( "UST_ShinyMaps", "piabenaud", ref = "dev")