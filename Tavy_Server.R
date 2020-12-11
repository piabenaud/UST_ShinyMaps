

# Make the basemap --------------------------------------------------------

tavy_pal <- colorFactor(palette = c("#1b9e77", "#d95f02", "#7570b3"), domain = Tavy_locs$Priority)

popup_tavy <- paste0("<b>","Coords: ","</b>", Tavy_locs$Easting,", ", Tavy_locs$Northing, "<br>",
                     "<b>","Description: ","</b>", Tavy_locs$Description, "<br>",
                     "<b>", "River: ", "</b>", Tavy_locs$River,"<br>",
                     "<b>", "Comments: ", "</b>", Tavy_locs$Comments, "<br>",
                     "<b>", "Visit By: ", "</b>", Tavy_locs$VisitBy, "<br>")

output$tavy_map <- renderLeaflet({
 leaflet() %>%  
    setView(lng = -4.14, lat = 50.54, zoom = 11) %>% 
    addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Colour") %>%
    addProviderTiles(providers$Esri.WorldImagery,
                     options = providerTileOptions(opacity = 0.3), group = "Colour") %>% 
    addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Gray-scale") %>% 
    addCircles(data = Tavy_locs, radius = 100, fillOpacity = 0.7, weight = 0.8, color = ~tavy_pal(Priority), popup = popup_tavy, label = ~FID, labelOptions = labelOptions(noHide = T, textsize = "10px", opacity = 0.7)) %>% 
    addLayersControl(
      options = layersControlOptions(collapsed = FALSE),
      baseGroups = c("Colour", "Gray-scale"),
      position = "topleft") %>% 
    addLegend("topleft", pal=tavy_pal, values=Tavy_locs$Priority, layerId="legend")
})

