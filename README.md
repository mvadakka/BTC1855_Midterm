# BTC1855_Midterm

Plan
1. EDA.R ---> Perform EDA on trips.csv and weather.csv. Remove NA/missing values. Factor categorical variables. Identify and remove cancelled trips. Identify and remove outliers. 

2. Find hours of weekdays where trip volume is highest (i.e. rush hours)
  2.1. 10 most frequent starting/ending stations during rush hours

3. 10 most frequent start/end stations during weekends

4. Average utilization of bikes for each month (total time used/total time in month)

5. Create new dataset combiing trip and weather data
  5.1. create correlation matric cor() and flag highest       correlations for team
  
Dictionary of folders:
- EDA plots - plots generated during EDA process
- csv - csv files generated across steps

Dictionary of files:
- EDA.R - EDA R script (Step 1 in Plan)
- removed.weather - removed missing data from weather.csv, speciffically in the precipitation_inches, max_gust_speed_mph, max_visibility_miles and max_gust_speed_mph columns
- removed.trips - removed cancelled data and outliers from trip.csv
