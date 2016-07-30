library(dplyr)
library(lubridate)

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
