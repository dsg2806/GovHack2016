# GovHack 2016
# Date:
# Authors: Andrew Chiu
#          John Le


# server.R

###########################################################################
#                             SHINYSERVER                                 #
###########################################################################

shinyServer(function(input, output) {


# Shiny Outputs -----------------------------------------------------------
  ###########################################################################
  #                           SHINY OUTPUTS                                 #
  ###########################################################################
  
  output$Date <- renderPrint({
    input$date
  })
  
  output$map1 <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%
    addMarkers(lng = 144.9631, lat = -37.8136)
      
  })
  
}) # End of shinyServer
