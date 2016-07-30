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
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
}) # End of shinyServer
