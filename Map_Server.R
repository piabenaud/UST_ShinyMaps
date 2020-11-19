
# Title:      UST3 Shiny App Map - The map server
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Make the basemap --------------------------------------------------------

output$map <- renderLeaflet({
  leaflet() %>%  
    setView(lng = -1.542, lat = 54.992, zoom = 6) %>% 
    addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Colour") %>%
    addProviderTiles(providers$Esri.WorldImagery,
                     options = providerTileOptions(opacity = 0.3), group = "Colour") %>% 
    addProviderTiles(providers$Esri.WorldShadedRelief, group = "Topography") %>% 
    addProviderTiles(providers$Esri.World, group = "Grey-scale")
})


# Let's define the colour palettes ----------------------------------------

observe({
  colorBy_low <- input$colour_low
  colorBy_up <- input$colour_up
  
  if (colorBy_low == "Rslt_Analysis") {
    colorData_low <- erosiondata_lowland$Rslt_Analysis
    pal <- colorBin(c("black", "#74add1", "#4575b4","#313695"), domain = colorData_low, bins = c(0,0.01,1,10,100), na.color = NA)
  } else {
    colorData_low <- erosiondata_lowland[[colorBy_low]]
    pal <- colorFactor(c("#440154FF", "#31688EFF", "#35B779FF","#FDE725FF"), colorData_low)
  }
  
  if (colorBy_up == "Rslt_Analysis") {
    colorData_up <- erosiondata_upland$Rslt_Analysis
    pal2 <- colorBin(c("black", "#ffffbf", "#fdae61", "#f46d43", "#a50026"), colorData_up, c(0.000,0.01,1,10,100, 10000), pretty = FALSE, na.color = NA)
  } else {
    colorData_up <- erosiondata_upland[[colorBy_up]]
    pal2 <- colorFactor(c("#440154FF", "#31688EFF", "#35B779FF","#FDE725FF"), colorData_up)
  }


# Let's add some popups ---------------------------------------------------

popups <- paste0("<b>","Land Cover: ","</b>", erosiondata_upland$Land_cover, "<br>",
                   "<b>","Study ID: ","</b>", erosiondata_upland$Site_ID, "<br>",
                   "<b>","Study Start: ","</b>", htmlEscape(erosiondata_upland$Stdy_Start), "<br>",
                   "<b>","Study Finish: ","</b>", htmlEscape(erosiondata_upland$Stdy_Fin), "<br>",
                   "<b>","Site selection: ","</b>", erosiondata_upland$Site_selection, "<br>",
                   "<b>","County: ","</b>", erosiondata_upland$County_Dis, "<br>")


# need to add something to link together shapefiles and popups


# Let's pull it all together ----------------------------------------------


