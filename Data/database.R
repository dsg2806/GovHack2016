###########################################################################
#                         LIBRARIES                                       #
###########################################################################

library(DBI)
library(RSQLite)

# Create new database -----------------------------------------------------
###########################################################################
#                           CREATE NEW DB                                 #
###########################################################################

mydb <- dbConnect(SQLite(), "my-db.sqlite")    # Create db called "my-db.sqlite"


# Load data into database -------------------------------------------------
###########################################################################
#                         LOAD DATA INTO DB                               #
###########################################################################

pedestrian_counts <- read.csv("Pedestrian_Counts.csv")
dbWriteTable(conn = mydb, 
             name = "pedestrian_counts", 
             value = pedestrian_counts)
rm(pedestrian_counts)

pedestrian_sensor_locations <- read.csv("Pedestrian_Sensor_Locations.csv")
dbWriteTable(conn = mydb,
             name = "pedestrian_sensor_locations",
             value = pedestrian_sensor_location)
rm(pedestrian_sensor_locations)

## Annual Patronage
annual_patronage <- read.csv("Annual Patronage.csv")



# Query database ----------------------------------------------------------
###########################################################################
#                            QUERY DATABASE                               #
###########################################################################
dbListTables(mydb)

dbListFields(mydb, "pedestrian_counts")

head(dbReadTable(mydb, "pedestrian_counts"))

dbGetQuery(mydb,
           "SELECT * FROM pedestrian_counts WHERE Month='June'")


# Disconnect from database ------------------------------------------------
###########################################################################
#                         DISCONNECT FROM DB                              #
###########################################################################
dbDisconnect(mydb)                             # Disconnects from db; saves into working directory

# unlink("my-db.sqlite")                       # Deletes db from working directory
