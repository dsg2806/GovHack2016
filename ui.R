# GovHack 2016
# Date:
# Authors: Andrew Chiu
#          John Le


# ui.R


# Header ------------------------------------------------------------------
###########################################################################
#                       HEADER LAYOUT                                     #
###########################################################################

header <- dashboardHeader(title = "Traffic and Public Transport")


# Sidebar Layout ----------------------------------------------------------
###########################################################################
#                            SIDEBAR LAYOUT                               #
###########################################################################

sidebar <- dashboardSidebar(
  sidebarMenu(id = "tabs",
              menuItem("Home",
                       tabName = "home", 
                       icon = icon("home")
                       ), # End of menuItem
              
              menuItem("Analysis",
                       tabName = "analysis", 
                       icon = icon("search")
                       ), # End of menuItem
              
              menuItem("Prediction",
                       tabName = "prediction", 
                       icon = icon("line-chart")
                       ), # End of menuItem
              
              menuItem("Map",
                       tabName = "map",
                       icon = icon("map-marker")   # alternatively: map, map-marker, map-pin
                       ), # End of menuItem
              
              menuItem("Data Sources",
                       tabName = "dataSources",
                       icon = icon("database")
                       ), # End of menuItem
              
              menuItem("UI",
                       tabName = "ui",
                       icon = icon("file-text")
                       ), # End of menuItem

              menuItem("Server",
                       tabName = "server",
                       icon = icon("file-text")
                       ), # End of menuItem
              
              menuItem("Global",
                       tabName = "global",
                       icon = icon("file-text")
                       ), # End of menuItem
              
              menuItem("About", 
                       tabName = "about", 
                       icon = icon("question")
                       ) # End of menuItem
              
              ) # End of sidebarMenu
  ) # End of dashboardSidebar


# Body Layout -------------------------------------------------------------

###########################################################################
#                             BODY LAYOUT                                 #
###########################################################################

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "home",
            fluidPage(
              fluidRow(
                includeMarkdown("README.Rmd")
              ) # End of fluidRow
              ) # End of fluidPage
            ), # End of HOME tabItem
    
    tabItem(tabName = "about",
            fluidPage(
              fluidRow(
                includeMarkdown("about.Rmd")
              ) # End of fluidRow
            ) # End of FluidPage
            ), # End of ABOUT tabItem
    
    tabItem(tabName = "analysis",
            fluidPage(
              fluidRow(
                h3("Analysis"),
                p("Visually show the correlation between weather data and
                  choice of transport")
              )
            )),
    
    tabItem(tabName = "prediction",
            fluidPage(
              fluidRow(
                h3("Prediction")
              )
            )),
    
    tabItem(tabName = "map",
            fluidPage(
              fluidRow(
                leafletOutput("map1")
              )
            )),
    
    tabItem(tabName = "dataSources",
            fluidPage(
              fluidRow(
                includeMarkdown("data sources.Rmd")
              ) # End of fluidRow
            ) # End of FluidPage
    ), # End of DATASOURCES tabItem
    
    tabItem(tabName = "ui",
            pre(includeText("ui.R"))
            ), # End of tabItem

    tabItem(tabName = "server",
            pre(includeText("server.R"))
            ), # End of tabItem
    
    tabItem(tabName = "global",
            pre(includeText("global.R"))
            ) # End of tabItem
    
    ) # End of tabItems
) # End of dashboardBody


# Putting it all together -------------------------------------------------
###########################################################################
#                       PUTTING IT ALL TOGETHER                           #
###########################################################################

## Header, Sidebar and Body has been defined above.
## This puts it all together

dashboardPage(header,
              sidebar,
              body,
              title = "GovHack", # title in the browser's title bar
              skin = "yellow"          # color theme (see ?dashboardPage)
              ) # End of dashboardPage