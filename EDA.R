#EDA Analysis on trips.csv

trips <- read.csv("/Users/mausamvk/Desktop/BTC1855/Midterm/trip.csv", header = TRUE)

install.packages("tidyverse")
install.packages("funModeling")
install.packages("Hmisc")

library(funModeling) 
library(tidyverse) 
library(Hmisc)

#Step 1: number of observations and varibales and view first cases
glimpse(trips) #here we see all variables are of type int or character
print(status(trips)) #here we see metrics: data types, zeroes, infinite/missing values

#Step 2: Use freq to analyze character/factor variables
freq(trips) 
freq(trips, path_out = ".") #export plots to jpeg in current directory

#Step 3: analyze numerical variables 
plot_num(trips)#returns a plot of numeric data
plot_num(trips, path_out = ".") #export plot

print(profiling_num(trips)) #runs for all numerical/integer variables to describe their distributions
  
#Step 4: analyze both numerical and categorical data to see overview of all variables
describe(trips)
