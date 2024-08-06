#The data science team assumes that weather conditions probably have an impact on the bike rental patterns, but they are not sure whether they should use temperature, weather events, visibility or other weather measurements available. 
#Help them decide by creating a new dataset combining trip data with the weather data. 

#New dataset with trip and weather data
#(Note that the weather data is available for each city and date. 
#Join your datasets accordingly).

#using prepped weather1 and trips1 dataframes
#prep dates for both dataframes into same y/m/d format
weather1$date <- ymd(weather1$date)
trips1$date <- ymd(trips1$date)

#load stations data
stations <- read.csv("/Users/mausamvk/Desktop/BTC1855/Midterm/station.csv", header = TRUE)

#join trips1 with stations by matching values in trips1 ="start_station_name" to stations="name"
trip.station <- trips1 %>%
  left_join(stations, by = c("start_station_name" = "name"))

#join trips_station with weather dataset using date and city
trip.weather <- trip.station %>%
  left_join(weather1, by = c("date" = "date", "city" = "city"))

#view weather and trip combined dataset
trip.weather ####getting NA's across all weather1 coloumns - indicating no matches found between trip.station and weather1 data frames - unable to resolve

#Create a correlation matrix for the new dataset using the cor() function from the corrplot package. 
#Flag the highest correlations for the data science team.
droplevels(trip.weather)
cor(trip.weather, use = "complete.obs") #as there are NA's in all weather1 data, this step could not be completed
