
# Title:      UST3 Shiny App Map - The map server
# Objective:  A Shiny App to map and explore the UST3 research activities
# Created by: Pia Benaud
# Created on: 19-11-2020


# Make the basemap --------------------------------------------------------

output$map <- renderLeaflet({
  leaflet() %>%  
    setView(lng = -3.812, lat = 50.801, zoom = 9) %>% 
    addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Colour") %>%
    addProviderTiles(providers$Esri.WorldImagery,
                     options = providerTileOptions(opacity = 0.3), group = "Colour") %>% 
    addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Gray-scale")
})



# Let's add some popups ---------------------------------------------------

popups <- paste0("<h3>", Catchments$WB_NAME,"</h3>", "<br>",
                 "<b>","Type: ","</b>", Catchments$Type, "<br>",
                 "<b>","Risk: ","</b>", Catchments$Risk, "<br>",
                 "<b>","Lead: ","</b>", Catchments$Lead, "<br>",
                 "<b>","Team: ","</b>", Catchments$Team, "<br>",
                 "<b>","Partners: ","</b>", Catchments$Partners, "<br>",
                 "<b>","WTW: ","</b>", Catchments$WTW, "<br>",
                 "<b>","Sondes: ","</b>", Catchments$Sondes, "<br>",
                 "<b>","Pumps: ","</b>", Catchments$Pumps, "<br>",
                 "<b>","Flow: ","</b>", Catchments$Flow, "<br>",
                 "<b>","Stage: ","</b>", Catchments$Stage, "<br>"
                 )

popup_temp <- paste0("<b>",BAU_shp$Catchment,"</b>")
# add wtw info

# Let's make a timeline plot -------------------------------------

# Could make this reactive in the future - i.e. as you zoom change to catchments in view

output$timeline <- renderPlot({
  ggplot(data = Catchments@data, aes(x = Project_End, y = WB_NAME)) +
    geom_segment(aes(x = Project_Start, xend = Project_End, y = WB_NAME, yend = WB_NAME), colour = "#264653") +
    geom_point(colour = "#f4a261", size = 4) +
    geom_vline(aes(xintercept = as.Date(today)), colour = "#2a9d8f", alpha = 0.5, size = 2) +
    labs(x = "Project Timeline", y = "Catchment") +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
    theme_classic() + 
    theme(axis.title = element_text(size = 10.5, colour = "gray20"),
          plot.title = element_text(colour = "gray20", size = 12, face = "bold"))
})
  

# Let's define the cols and bring it all together -------------------------


#pal_test <- c("#264653", "#2a9d8f", "#e9c46a", "#f4a261", "#e76f51", "#6b8b8d")

observe({
  colour_by <- input$colour # First defining the colour palettes for the input (on ui) 'colour'
  
  if (colour_by == "Type") {
    colour_group <- Catchments$Type
    pal <- colorFactor( palette = c("#1b9e77", "#d95f02", "#7570b3"), domain = colour_group)
    
  } else if (colour_by == "Lead") {
    colour_group <- Catchments[[colour_by]]
    pal <- colorFactor(palette = c("#1b9e77", "#d95f02", "#7570b3", "#e7298a"), domain= colour_group)
    
  } else {
    colour_group <- Catchments[[colour_by]] # i.e. Catchment Group
    pal <- colorFactor(palette = c("#1b9e77", "#d95f02", "#7570b3"), domain= colour_group)
  }
  
  
  leafletProxy("map") %>%  # Then adding it all to the map
    clearShapes() %>%
    addPolygons(data = BAU_shp, group = "BAU", fillOpacity = 0.5, weight = 0.8, color = "#6b8b8d", popup = popup_temp) %>%
    addPolygons(data = Catchments, group = "Catchments", fillOpacity = 0.8, weight = 0.8, color = pal(colour_group), popup = popups) %>%
    #addCircles(data = erosiondata_lowland, group = "Lowland", ~Long, ~Lat, radius = rad_low, layerId=~Site_ID,  # add something like this later for point-based data
    #           stroke=FALSE, fillOpacity=0.65, fillColor=pal(colorData_low), popup = popup_low) %>%
    addLayersControl(
      options = layersControlOptions(collapsed = FALSE),
      overlayGroups = c("Catchments", "BAU"),
      baseGroups = c("Colour", "Gray-scale"),
      position = "topleft") %>% 
    addLegend("topleft", pal=pal, values=colour_group, layerId="legend")
  
})