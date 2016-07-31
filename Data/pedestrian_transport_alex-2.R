#mean ratios version, every day data

library(dplyr)
library(lubridate)

Pedestrians <- read.csv("Data/Pedestrian/pedestrians by date.csv")
Buses <- read.csv("Data/Bus-calculated-Alex-data-only.csv",col.names=c("Year", "Bus.annual", "Bus.daily","DataType"))
Trains <- read.csv("Data/Train/Train-calculated-AL-data-only.csv",col.names=c("Year", "Train.annual", "Train.daily","DataType"))

Pedestrians$Date <- as.Date(Pedestrians$Date)


TramDailyAverage <- 500000

#Excluding Flinders

Pedestrians <- filter(Pedestrians,Sensor_Name!='Flinders Street Station Underpass')

l <- nrow(Pedestrians)
Combined <- mutate(Pedestrians, Bus=0, Tram=0, Train=0, PedBusRatio=0, PedTramRatio=0, PedTrainRatio=0)

for (i in 1:l)
        {
        y<-year(Pedestrians$Date[i])
        
        Combined$Tram[i] <- TramDailyAverage
       
        Tbus <- filter(Buses, Year==y)
        Ttrain <- filter(Trains, Year==y)
        Combined$Bus[i] <- Tbus$Bus.daily   
        Combined$Train[i] <- Ttrain$Train.daily  
        }

Combined <- mutate(Combined, PedBusRatio=sum.Hourly_Counts./Bus, PedTramRatio=sum.Hourly_Counts./Tram, PedTrainRatio=sum.Hourly_Counts./Train)
write.csv(Combined, file="PedTramBusTrainCombined.csv")
