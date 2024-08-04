#### Highest volume hours on weekdays
library(lubridate)
library(dplyr)
library(ggplot2)

#convert start_date and end_date from characters to date and time - m/d/y, hours:min
trips1$start.date <- mdy_hm(trips1$start_date)
trips1$end.date <- mdy_hm(trips1$end_date)

is.timepoint(trips1$start.date) #check if its in date-time format, it is!
is.timepoint(trips1$end.date) #check if its in date-time format

#assign trips1 to days, as to not alter trips1 dataset for use downstream
days <- trips1

#extract days from dates in start_date and end_date, where 1-5 are weekdays and 6/7 are weekends
#store in start.wday
days  <- days %>% 
  mutate(start.wday = wday(days$start.date))

#store weekday in end.wday
days <- days %>% 
  mutate(end.wday = wday(days$end.date))

#subset days where start.wday and end.wday <6 i.e. weekdays only, save to weekdays
weekdays <- subset(days, start.wday < 6 & end.wday < 6)

#check only values below 6 are present in start.wday and end.wday
sum(weekdays$start.wday > 5) #0 values greater than 5
sum(weekdays$end.wday > 5) #0 values greater than 5

#factor start.wday and end.wday, as each value corresponds to a weekday
weekdays$start.wday <- as.factor(weekdays$start.wday)
weekdays$end.wday <- as.factor(weekdays$end.wday)

summary(weekdays$start.wday) #here we can see min values are 1, max is 5, and breakdown per day
summary(weekdays$end.wday)

#getting hours and minutes from date in start.date
weekdays$start.hour <- format(as.POSIXct(weekdays$start.date), format = "%H")

#convert hours to numeric
weekdays$start.hour <- as.numeric(weekdays$start.hour)

#then convert hours to factor, so we can see count per hour
weekdays$start.hour <- as.factor(weekdays$start.hour)

#combine start.hour and start.wday coloumns to create list of volume and day
volume <- as.data.frame(cbind(weekdays$start.hour, weekdays$start.wday))
colnames(volume) <- c("Hour", "Weekday")

#group by weekdays, and count instances of trips per hour, per weekday
volume.count <- volume %>% group_by_all() %>% count

#order volume.count based on highest count of trips to lower, to easily see which hours on what day have largest volume of trips
highest.volume <- volume.count[order(volume.count$n, decreasing = TRUE),]
highest.volume #here we can see largest frequency of trips occurred on hour 9, for weekdays 3,4,2 and 5. Followed by hour 18 and 10. 

#save highest.volume as csv 
write.csv(highest.volume, "/Users/mausamvk/BTC1855_Midterm/csv/highest_volumehours.csv", row.names=FALSE)

#plot hourly trip usage on weekdays
hourly <- ggplot(data = weekdays, aes(x = start.hour)) + 
      labs(title = "Volume of trips on weekdays per hour",
      subtitle = "(based on start times of weekday trips)",
      y = "Count of trips", x = "Hour") + geom_bar(color="white") 

#plot hourly trip usage per day and flip plots sideways
trip_volume <- hourly + facet_wrap(~ start.wday) + coord_flip()

#save plot
ggsave(plot = trip_volume, filename = "trip_volume.pdf", path = "/Users/mausamvk/BTC1855_Midterm/Plots")

  