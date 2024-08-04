#Calculate average utilization of bikes for each month 
#(total time used/total time in month)

#subset trips1 dataframe for info needed; ID, bike_id, duration, start.date
#we only need start.date to extract the month in which the trip took place
bike <- data.frame(trips1$id, trips1$bike_id, trips1$duration, trips1$start.date)
colnames(bike) <- c("id", "bike_id", "duration", "start.date")

#get months from bike$start.date, assign as bike$month
library(lubridate)
bike$month <- format(as.POSIXct(bike$start.date), format = "%m")

#see structure of bike variables; month is character rest are int or POSIXct format
str(bike)

#convert month to factor so we can group months together later
bike$month <- as.factor(bike$month)
str(bike) #now we see months as factor w 12 levels

######convert bike_id to factors so same ids can be goruped together later
b <- bike

b$bike_id <- as.factor(b$bike_id)

#group duration by months
bike.months <- bike %>% group_by(bike$month)

#sum duration, by month, rename coloumns names to months
utilization <- as.data.frame.list(tapply(bike$duration, bike$month, FUN=sum))
colnames(utilization) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                           "Aug", "Sep", "Oct", "Nov", "Dec")

#duration is in seconds, and average legnth of month (accounting of variation in days per month) is 30.437
#Thus, average seconds in a month are 2629756.8 seconds

#divide each duration by 2629756.8s, multiple by 100, to get percent of avergae utilization per month
avg.utilization <- (utilization/2629756.8)*100
avg.utilization #avg utilization per month, based on total time in month 
