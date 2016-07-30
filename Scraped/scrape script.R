
# Example links -----------------------------------------------------------

# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Aug/VSDATA_20150831.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Sep/VSDATA_20150930.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Oct/VSDATA_20151029.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Nov/vsdata_20151130.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Dec/vsdata_20151227.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2016/July/VSDATA_20160720.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2016/June/VSDATA_20160628.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Apr/VSDATA_20150403.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Mar/VSDATA_20150302.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2016/February/VSDATA_20160229.zip"
# "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2015/Jan/VSDATA_20150101.zip"


# This works!!! -----------------------------------------------------------


temp <- tempfile()

fileurl <- "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2014/Jan/VSDATA_20140101.zip"

download.file(fileurl, temp)

temp <- read.csv(unz(temp, filename = "VSDATA_20140101.csv"))

temp <- tempfile()

fileurl <- "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/2014/Jan/VSDATA_20140102.zip"

download.file(fileurl, temp)

temp2 <- read.csv(unz(temp, filename = "VSDATA_20140102.csv"))


# Start Scaping code ------------------------------------------------------

library(dplyr)

years <- c("2014", "2015", "2016")
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec") # For 2014 - 2015
months <- c("Jan", "February", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec") # for 2016 because VicRoads uses inconsistent month formats!!!
months2 <- c("01", "02", "03", "04", "05", "06", "07", "08","09", "10", "11", "12")
days <- c("01", "02", "03", "04", "05", "06", "07", "08","09", "10",
          "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
          "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31")
url <- "https://vicroads-public.sharepoint.com/InformationAccess/Shared%20Documents/Traffic%20Measurements/Volume/Road/Signal%20Volume%20Data/"

scrape <- function(fileurl, filename2) {    # function to scrape and save files

  temp <- tempfile()
  
  download.file(fileurl, temp)
  
  temp <- read.csv(unz(temp, filename = filename2))
  
    ## Select Blackburn, Carlton, Doncaster and Melbourne City
  temp <- filter(temp, NM_REGION %in% c("BBN", "CA1", "CA2", "DON", "MC1", "MC2", "MC3"))
  
  write.csv(temp, file = filename2, row.names = F)
}

for (i in years) {      # Loop through years
  for (j in 1:12) {     # Loop through months
    for (k in days) {   # Loop through days; need error handling since not all months have 31 days
      
      fileurl <- paste(url, i, "/", months[j], "/VSDATA_", i, months2[j], k, ".zip",  sep = "")
      
      #filename <- paste("VSDATA_", i, months2[j], k, ".zip", sep = "")
      
      filename2 <- paste("VSDATA_", i, months2[j], k, ".csv", sep = "")
      
      #print(filename2)   # For diagnosis
      
      if(!file.exists(filename2)) {   # If the file has already been saved due to prior iteration of dodgey code
        try(scrape(fileurl, filename2))   # Error handling for months where days < 31
      }
      
    }
  }
}


# Prototype ---------------------------------------------------------------

for (i in years) {      # Loop through years
  for (j in 1:12) {     # Loop through months
    for (k in days) {   # Loop through days; need error handling since not all months have 31 days

        temp <- tempfile()
        
        fileurl <- paste(url, i, "/", months[j], "/VSDATA_", i, months2[j], k, ".zip",  sep = "")
        
        #filename <- paste("VSDATA_", i, months2[j], k, ".zip", sep = "")
        
        filename2 <- paste("VSDATA_", i, months2[j], k, ".csv", sep = "")
        
        #print(filename2)   # For diagnosis

        if(!file.exists(filename2)) {   # If the file has already been saved due to prior iteration of dodgey code
          download.file(fileurl, temp)
          
          temp <- read.csv(unz(temp, filename = filename2))
          
          write.csv(temp, file = filename2, row.names = F)
        }
      
    }
  }
}
