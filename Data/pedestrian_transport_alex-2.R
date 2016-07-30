#mean ratios version, every day data

library(dplyr)
library(lubridate)

Pedestrians <- read.csv("Data/Pedestrian/pedestrians by date.csv")
Buses <- read.csv("Data/Bus-calculated-Alex-data-only.csv",col.names=c("Year", "Bus.annual", "Bus.daily","DataType"))
Pedestrians$Date <- as.Date(Pedestrians$Date)


TramDailyAverage <- 500000

Flagstaff = filter(Pedestrians,Sensor_Name=='Flagstaff Station')
Flinders = filter(Pedestrians,Sensor_Name=='Flinders Street Station Underpass')
SouthernCross= filter(Pedestrians,Sensor_Name=='Southern Cross Station')


l <- nrow(Pedestrians)
Combined <- mutate(Pedestrians, Bus=0, Tram=0, PedBusRatio=0, PedTramRatio=0)

for (i in 1:l)
        {
        y<-year(Pedestrians$Date[i])
        
        Combined$Tram[i] <- TramDailyAverage
       
        Tbus <- filter(Buses, Year==y)
        Combined$Bus[i] <- Tbus$Bus.daily   
        }

Combined <- mutate(Combined, PedBusRatio=sum.Hourly_Counts./Bus, PedTramRatio=sum.Hourly_Counts./Tram)
write.csv(Combined, file="PedTramBusCombined.csv")
