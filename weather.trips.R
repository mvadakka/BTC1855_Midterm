#The data science team assumes that weather conditions probably have an impact on the bike rental patterns, but they are not sure whether they should use temperature, weather events, visibility or other weather measurements available. 
#Help them decide by creating a new dataset combining trip data with the weather data. 

#New dataset with trip and weather data
#(Note that the weather data is available for each city and date. 
#Join your datasets accordingly).

#using prepped weather1 and trips1 dataframes
#prep dates for both dataframes into same y/m/d format
weather1$date <- mdy(weather1$date)
trips1$date <- ymd(trips1$date)

#load stations data
stations <- read.csv("/Users/mausamvk/Desktop/BTC1855/Midterm/station.csv", header = TRUE)

#join trips1 with stations by matching values in trips1 ="start_station_name" to stations="name"
trip.station <- left_join(trips1, stations, by = c("start_station_name" = "name"))

#make sure weather$date is in date format
weather$date <- mdy(weather$date)
  
#join trips_station with weather dataset using date and city
trip.weather <-  left_join(trip.station, weather, by = c( "date", "city"))


#view weather and trip combined dataset
trip.weather

#Create a correlation matrix for the new dataset using the cor() function from the corrplot package. 
#cor() only takes numeric input, remove all other datatypes
summary(trip.weather) #here we see events, precipitation_inches, installation_date, city, subscription_type, zip_code.x,  
                      #end_station_name, end_date, start_station_name and start_date as character so we remove them.    

attach(trip.weather)
trip.weather <- subset(trip.weather, select = -c(events,precipitation_inches,installation_date,city,subscription_type,zip_code.x,
                                      zip_code.y,end_station_name,end_date,start_station_name,start_date))

#some more variables aren't relevant to correlation between weather and trips, remove them
trip.weather <- subset(trip.weather, select = -c(start.date, end.date, id.x, id.y, date, start_station_id, end_station_id, bike_id))

droplevels(trip.weather) #remove any factored data

#convert all variables to numeric (some are still integer)
trip.weather[] <- sapply(trip.weather, as.numeric)

#find correlation of duration of trip, with weather. 
#use pairwise.complete.obs to deal with NA values, and save as dataframe
correlation <- as.matrix(cor(trip.weather, trip.weather$duration, use = "pairwise.complete.obs")) 

#Flag the highest correlations for the data science team
#order correlations from highest to lowest; where correlation greater than 0.5 or less than -0.5 indicate moderate to strong correlation
correlation[,1] <- correlation[order(correlation[,1], decreasing = TRUE),]
colnames(correlation) <- c("Duration")

#correlation matrix
correlation

