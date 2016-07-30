library(dplyr)
library(lubridate)

## Load Pedestrian Data
pedestrian_counts <- read.csv("Pedestrian_Counts.csv")

head(pedestrian_counts, 20)
str(pedestrian_counts)
unique(pedestrian_counts$Sensor_Name)

## Subset to:
## - Flinders Street Station Underpass
## - Flagstaff Station
## - Southern Cross Station

pedestrian_counts <- filter(pedestrian_counts, Sensor_Name %in% c("Flinders Street Station Underpass", "Flagstaff Station", "Southern Cross Station"))

## Extract Date information
pedestrian_counts$Date_Time <- dmy_hm(pedestrian_counts$Date_Time)
pedestrian_counts$Date <- as.Date(pedestrian_counts$Date_Time)

## Summarise pedestrians by STATION and DAY

pedestrians_by_date <- pedestrian_counts %>%
                          group_by(Sensor_Name, Date) %>%
                          summarise(sum(Hourly_Counts))
head(pedestrians_by_date)

## Load Patronage Data
