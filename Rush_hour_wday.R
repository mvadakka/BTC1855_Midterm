#Top 10 start and end stations during weekday rush hours#
#########################################################

# rush hour = So 9am, 10am, and 6pm (or 18)
#use weekdays dataframe as it includes data only from weekdays

#first subset weekdays to only include rush hour info (9, 10, or 18)
rush.hour <- subset(weekdays, start.hour == 9 | start.hour == 10 | start.hour == 18)

#check if station names are factored
levels(rush.hour$start_station_name) #start station names are factored
levels(rush.hour$start_station_id) #start station ID's are not
rush.hour$start_station_id <- as.factor(rush.hour$start_station_id) #factor start station ID

#subset start station names, ids, hour
rush.start.stations <- data.frame(rush.hour$start_station_id, rush.hour$start_station_name, rush.hour$start.hour)

#groupby start stations names, and count frequencies to indicate # of trips
freq.start.stations <- rush.start.stations %>% group_by(rush.hour$start_station_name) %>% count

#order by greatest freq. to least
highest.start.stations <- freq.start.stations[order(freq.start.stations$n, decreasing = TRUE),]
print(highest.start.stations, n=10) #top 10 used start subway statons during rush hour


#repeat steps for end stations#
#check if end station names are factored
levels(rush.hour$end_station_name) #end station names are
levels(rush.hour$end_station_id) #end station ID's are not
rush.hour$end_station_id <- as.factor(rush.hour$end_station_id) #factor end station ID

#subset end station names, ids, hour
rush.end.stations <- data.frame(rush.hour$end_station_id, rush.hour$end_station_name, rush.hour$end.hour)

#groupby end stations names, and count frequencies to indicate # of trips
freq.end.stations <- rush.end.stations %>% group_by(rush.hour$end_station_name) %>% count

#order by greatest freq. to least
highest.end.stations <- freq.end.stations[order(freq.end.stations$n, decreasing = TRUE),]
print(highest.end.stations, n=10) #top 10 used end subway stations during rush hour
