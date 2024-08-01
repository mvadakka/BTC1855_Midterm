#################################
### EDA Analysis on trips.csv ###
#################################

trips <- read.csv("/Users/mausamvk/Desktop/BTC1855/Midterm/trip.csv", header = TRUE)

install.packages("tidyverse")
install.packages("funModeling")
install.packages("Hmisc")

library(funModeling) 
library(tidyverse) 
library(Hmisc)
library(dplyr)

#Step 1: number of observations and variables and view first cases
glimpse(trips) #here we see all variables are of type int or character
status(trips) #here we see metrics: data types, zeroes, infinite/missing values. There are 50 zeroes in zip_code, no NA or infinity values acorss variables, and subscription_type with only 2 unique values

#Step 2: Use freq to analyze character/factor variables
freq(trips) 
freq(trips, path_out = ".") #export plots to jpeg in current directory

#Step 3: analyze numerical variables 
plot_num(trips)#returns a plot of numeric data
plot_num(trips, path_out = ".") #export plot

print(profiling_num(trips)) #runs for all numerical/integer variables to describe their distributions
  
#Step 4: analyze both numerical and categorical data to see overview of all variables
describe(trips)

###################################
### EDA Analysis on weather.csv ###
###################################

weather <- read.csv("/Users/mausamvk/Desktop/BTC1855/Midterm/weather.csv", header = TRUE)
summary(weather)

#Step 1: number of observations and variables and view first cases
glimpse(weather) #here we see all variables are of type int or character
status(weather) #here we see metrics: data types, zeroes, infinite/missing values. There are 50 zeroes in zip_code, no NA or infinity values acorss variables, and subscription_type with only 2 unique values

#Step 2: Use freq to analyze character/factor variables
freq(weather) 
freq(weather, path_out = ".") #export plots to jpeg in current directory

#Step 3: analyze numerical variables 
plot_num(weather)#returns a plot of numeric data
plot_num(weather, path_out = "/Users/mausamvk/BTC1855_Midterm/EDA plots") #export plot

print(profiling_num(weather)) #runs for all numerical/integer variables to describe their distributions

#Step 4: analyze both numerical and categorical data to see overview of all variables
describe(weather)


#####################################
######### Data Cleaning #############
#####################################

#######Trips Data
#Save Trips data in new dataframe, so original is not edited 
trips1 <- trips

#convert categorical variables to factors
summary(trips1)

trips1$start_station_name <- as.factor(trips1$start_station_name)
levels(trips1$start_station_name)

trips1$end_station_name <- as.factor(trips1$end_station_name)
levels(trips1$end_station_name)

trips1$subscription_type <- as.factor(trips1$subscription_type)
levels(trips1$subscription_type)

##########Weather Data
#Save weather data in new dataframe, so original is not edits 
weather1 <- weather
summary(weather1)

#store IDs of NA/empty values across mex_gust_speed_mph 
missing_maxgust <- weather1[(is.na(weather1$max_gust_speed_mph) | weather1$max_gust_speed_mph==""), ]
#remove NA or empty values across mex_gust_speed_mph 
weather1 <- weather1[!(is.na(weather1$max_gust_speed_mph) | weather1$max_gust_speed_mph==""), ]

#check which variables still have NA/missing values 
summary(weather1) # max_visibility, mean_visibility, preciptation_inches

#store IDs of NA/empty values across precipitation_inches 
missing_precipitation <- weather1[(is.na(weather1$precipitation_inches) | weather1$precipitation_inches==""), ]
#remove NA or empty values across mex_gust_speed_mph 
weather1 <- weather1[!(is.na(weather1$precipitation_inches) | weather1$precipitation_inches==""), ]

#store IDs of NA/empty values across max_visibility_miles 
missing_maxvisibility <- weather1[(is.na(weather1$max_visibility_miles) | weather1$max_visibility_miles==""), ]
#remove NA or empty values across mex_gust_speed_mph 
weather1 <- weather1[!(is.na(weather1$max_visibility_miles) | weather1$max_visibility_miles==""), ]

#convert Date variable from character to date
weather1$date 
library(lubridate)
weather1$date <- as.Date(weather1$date, "%m/%d/%y") #convert to m/d/y

#convert precipitation)inches to numerical from character
weather1$precipitation_inches <- as.numeric(weather1$precipitation_inches)

#convert events as.factor
weather1$events <- as.factor(weather1$events)
levels(weather1$events)


#####################################
######### Cancelled Trips ###########
#####################################

# Any trip starting and ending at the same station, with duration less than 3 minutes is likely a 'cancelled trip'. 
#Find out the number of such trips, record the trip ids for your report and then remove them from the dataset.

attach(trips1)
duration #seems like duration time is in second not minutes, thus we will use threhsold of 180seconds instead

#storing IDs of cancelled trips that will be removed
three_mins <- trips1 %>% #filter durations less than 180 seconds
  filter(duration < 180)

cancelled_trips <- three_mins %>% #filter three_mins dataset for same start and end stations, indicating cancelled
  filter(start_station_name == end_station_name) 

cancelled_trips$id #ID of all trips that start and end at same station and are less than 3 mins (180 seconds) in duration

#removing cancelled trips
trips1 <- trips1 %>% #filter durations less than 180 seconds
  filter(!duration < 180)

trips1 <- trips1 %>% #filter three_mins dataset for same start and end stations, indicating cancelled
  filter(start_station_name != end_station_name) 

sum(trips1$duration <180) #check there are no trips shorter than 3 mins
sum(trips1$start_station_name == trips1$end_station_name) #check there are no start and end stop names that are the same

trips1 #cancelled trips have been removed!


#####################################
############ Outliers ###############
#####################################

attach(trips1)

#view trips data distributions and other descriptors 
summary(trips1)

plot(duration) #we see extreme outliers
boxplot(duration) #can seee here as well

max(duration) #17270400 seconds
min(duration) #180 seconds
mean(duration) #961.7805 s
median(duration) #514 s

## EDIT FROM HERE!
#order dataframe by length of duration, in decreasing order
tt <- trips1[order(trips1$duration, decreasing = TRUE),]

#find IQR
#find IQR for duration.seconds and remove outliers 
Q1 <- quantile(duration, .25) #25% of data is below 354 s

Q3 <- quantile(duration, .75) #75% is below 732 s

IQR <- IQR(duration) #IQR is 378

testing <- subset(trips1, duration > (Q1 - 1.5*IQR) & duration < (Q3 + 1.5*IQR))
max(testing$duration) #1298

