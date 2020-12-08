(
  div(class="outer",
      
      tags$head(
        includeCSS("styles.css") # Include our custom CSS
      ),
      
      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("tavy_map", width="100%", height="100%"),
    
      )
  )
