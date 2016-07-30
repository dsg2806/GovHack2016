library(dplyr)
library(lubridate)



# Temperature -------------------------------------------------------------

temperature <- read.csv("Data/Weather/melTempArchive.csv")

temperature$Date <-  paste(temperature$Year, 
                           temperature$Month, 
                           temperature$Day, 
                           sep = "-")
temperature$Date <- ymd(temperature$Date)

temperature <- filter(temperature, Year > 2008) %>%
               select(temperature, 
                      Date, 
                      Maximum.temperature..Degree.C., 
                      Minimum.temperature..Degree.C.)

names(temperature) <- c("date", "maxTemp", "minTemp")

head(temperature)

# write.csv( temperature, "temperatures.csv", row.names = F)


# Rainfall ----------------------------------------------------------------

rainfall <- read.csv("Data/Weather/melRainfall.csv")

head(rainfall)

rainfall$Date <- paste(rainfall$Year, 
                       rainfall$Month, 
                       rainfall$Day, 
                       sep = "-")
rainfall$Date <- ymd(rainfall$Date)

rainfall <- filter(rainfall, Year > 2008) %>%
            select(Date, 
                   Rainfall.amount..millimetres.)

names(rainfall) <- c("date", "rainfall_mm")

head(rainfall)

# write.csv(rainfall, "rainfall.csv", row.names = F)


# Combine weather data ----------------------------------------------------
head(rainfall)
head(weather)

weather <- left_join(rainfall, temperature, by = "date")

head(weather)


write.csv(weather, "weather.csv", row.names = F)
