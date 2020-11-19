
(
  div(class="outer",
      
      tags$head(
        includeCSS("styles.css") # Include our custom CSS
      ),
      
      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("map", width="100%", height="100%"),
      
      # Shiny versions prior to 0.11 should use class = "modal" instead.
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    
                    h3("Colour controller"),
                    
                    selectInput("colour_investigation", "Investigation colour", vars),
                    selectInput("colour_scheme", "Scheme colour", vars),
                    selectInput("colour_BAU", "BAU colour", vars)
                    
                    
      )
  )
)