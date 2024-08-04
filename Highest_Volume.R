#### Highest volume hours on weekdays
#highest volume hours on weekdays, so that they can build 'rush hours' into their model (lubridate package is your BFF here). 
# You can choose the specific approach to take, but you have to find the hours of weekdays where the trip volume is highest. 
# (e.g. you may try histograms)
library(lubridate)
library(dplyr)

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

###work from here to find hours with most trips in weekdays
#getting hours and minutes from start_date, to see when trip started
test <- weekdays

test$start.time <- format(as.POSIXct(weekdays$start_date), format = "%H")
attach(test)

#plot histogram of start.times, per weekday
hourly.plot1 <- ggplot(data = test, aes(start.time, n)) +
                  geom_line(color = "steelblue", linewidth = 1) +
                  geom_point(color="steelblue") + 
                  labs(title = "Highest volume hours on weekdays",
                       subtitle = "(based on start times of weekday trips)",
                       y = "Count of trips", x = "Hour") + 
                  facet_wrap(~ start.wday)
