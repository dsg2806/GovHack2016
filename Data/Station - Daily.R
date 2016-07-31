library(dplyr)
library(lubridate)


# Southern Cross ----------------------------------------------------------

southern <- read.csv("Data/Pedestrian/pedestrians by date.csv") %>%
  filter(Sensor_Name %in% c("Southern Cross Station"))

names(southern)[3] <- "Daily_Count"

summary(southern)


southern$Year <- year(southern$Date)

southern <- group_by(southern, Year)

temp <- summarise(southern, sum(Daily_Count))
head(temp)

southern <- left_join(southern, temp, by = "Year")

southern <- mutate(southern, percentage_of_year = Daily_Count / sum(Daily_Count))

head(southern)


# Flagstaff ---------------------------------------------------------------

flagstaff <- read.csv("Data/Pedestrian/pedestrians by date.csv") %>%
  filter(Sensor_Name %in% c("Southern Cross Station"))

names(flagstaff)[3] <- "Daily_Count"

summary(flagstaff)


flagstaff$Year <- year(flagstaff$Date)

flagstaff <- group_by(flagstaff, Year)

temp <- summarise(flagstaff, sum(Daily_Count))
head(temp)

flagstaff <- left_join(flagstaff, temp, by = "Year")

flagstaff <- mutate(flagstaff, percentage_of_year = Daily_Count / sum(Daily_Count))

head(flagstaff)


# Average Percentage ------------------------------------------------------

flagstaff <- as.data.frame(flagstaff)
southern <- as.data.frame(southern)
str(flagstaff)
str(southern)


temp <- left_join(flagstaff, southern, by = "Date") %>%
        select(Date, percentage_of_year.x, percentage_of_year.y, Year.x)
names(temp) <- c("Date", "flagstaff", "southern", "Year")
temp <- mutate(temp, avg_percentage = (flagstaff + southern) / 2) %>%
        select(Date, avg_percentage, Year)


head(temp)
summary(temp)


# Combine with train data -------------------------------------------------

train <- read.csv("Data/Train/Annual Patronage.csv")
train$Financial.Year <- as.character(train$Financial.Year)
names(train)[3] <- "Patronage"
train$Patronage <- train$Patronage * 1000000

train$Year <- sapply(train$Financial.Year, function(x) strsplit(x, "-")[[1]][1])

train <- filter(train, Year != "2008")
train$Year <- as.numeric(train$Year)

head(train)
tail(train)

# aircraft <- temp
# aircraft2 <- train[train$Station == "Aircraft",]
# 
# aircraft <- left_join(aircraft, aircraft2, by = "Year") %>%
#             mutate(Daily_Patronage = Patronage * avg_percentage) %>%
#             select(Date, Station, Daily_Patronage)
# head(aircraft)

for (i in train$Station) {
  
  station_temp <- train[train$Station == i,]
  
  station_temp <- left_join(temp, station_temp, by = "Year") %>%
                  mutate(Daily_Patronage = Patronage * avg_percentage) %>%
                  select(Date, Station, Daily_Patronage)
  
  if(i == "Aircraft") {
    all <- station_temp
  }
  else {
    all <- rbind(all, station_temp)
  }
}

all <- arrange(all, Station)

write.csv(all, "Station - Daily.csv", row.names = F)
