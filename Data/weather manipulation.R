library(dplyr)
library(lubridate)



# Temperature -------------------------------------------------------------

weather <- read.csv("Data/Weather/melTempArchive.csv")

head(weather)

str(weather)

unique(weather$Year)

weather$Date <-  paste(weather$Year, weather$Month, weather$Day, sep = "-")

weather$Date <- ymd(weather$Date)

weather <- filter(weather, Year > 2008)

weather <- select(weather, Date, Maximum.temperature..Degree.C., Minimum.temperature..Degree.C.)

names(weather) <- c("date", "maxTemp", "minTemp")

head(weather)

write.csv( weather, "temperatures.csv", row.names = F)


# Rainfaill ---------------------------------------------------------------

rainfall <- read.csv("Data/Weather/melRainfall.csv")

head(rainfall)

rainfall$Date <- paste(rainfall$Year, rainfall$Month, rainfall$Day, sep = "-")
rainfall$Date <- ymd(rainfall$Date)

rainfall <- filter(rainfall, Year > 2008) %>%
            select(Date, Rainfall.amount..millimetres.)
head(rainfall)

write.csv(rainfall, "rainfall.csv", row.names = F)
