#Top 10 starting/ending stations during the weekends#
#####################################################

#use days dataset; includes the day from all dates

#subset days where start.wday and end.wday > 5 i.e. wekeends only, save to weekends
weekends <- subset(days, start.wday > 5 & end.wday > 5)

summary(weekends$start.wday) #min is 6, max is 7; only weekends
summary(weekends$end.wday)

#check if station names are factored
levels(weekends$start_station_name) #start station names are factored
levels(weekends$start_station_id) #start station ID's are not
weekends$start_station_id <- as.factor(weekends$start_station_id) #factor start station ID

#subset start station names and ids, and assign to weekend.start.stations
weekend.start.stations <- data.frame(weekends$start_station_id, weekends$start_station_name)

#groupby start stations names, and count frequencies to indicate # of trips
library(dplyr)
freq.weekend.stations <- weekend.start.stations %>% group_by(weekends$start_station_name) %>% count

#order by greatest freq. to least
high.weekend.start <-freq.weekend.stations[order(freq.weekend.stations$n, decreasing = TRUE),]
print(high.weekend.start, n=10) #top 10 used start subway stations during weekends

#repeat steps for end stations#

#check if station names are factored
levels(weekends$end_station_name) #start station names are factored
levels(weekends$end_station_id) #start station ID's are not
weekends$end_station_id <- as.factor(weekends$end_station_id) #factor start station ID

#subset end station names and ids, and assign to weekend.end.stations
weekend.end.stations <- data.frame(weekends$end_station_id, weekends$end_station_name)

#groupby end stations names, and count frequencies to indicate # of trips
library(dplyr)
freq.endweekend.stations <- weekend.end.stations %>% group_by(weekends$end_station_name) %>% count

#order by greatest freq. to least
high.endweekend.start <-freq.endweekend.stations[order(freq.endweekend.stations$n, decreasing = TRUE),]
print(high.endweekend.start, n=10) #top 10 used end subway stations during weekends

