# BTC1855_Midterm
#Plan
1. EDA.R ---> Perform EDA on trips.csv and weather.csv. Remove NA/missing values. Factor categorical variables. Identify and remove cancelled trips. Identify and remove outliers. 

2. Highest_volume.R --->  Find hours of weekdays where trip volume is highest (i.e. rush hours)

2.1. Rush_hour_wday.R --> Find 10 most frequent starting/ending stations during weekday rush hours

3. Wknd_10stations.R --> Find 10 most frequent start/end stations during weekends

4. Average_Utilization.R ---> Determine average utilization of bikes for each month (total time used/total time in month)

5. Create new dataset combiing trip and weather data
  5.1. create correlation matric cor() and flag highest correlations for team
  
#Dictionary of folders:
- EDA plots - plots generated during EDA process
- csv - csv files generated across steps

#Dictionary of files:
- EDA.R: EDA R script (Step 1 in Plan)
- removed.weather: removed missing data from weather.csv, speciffically in the precipitation_inches, max_gust_speed_mph, max_visibility_miles and max_gust_speed_mph columns
- removed.trips: removed cancelled data and outliers from trip.csv
- Highest_volume.R: Script to determine hours of weekdays where trip volume is highest and plot (Step 2)
- highest_volumehours.csv: csv file of frequency of trips per hour, per weekday, arranged by greatest frequncy to least
- Rush_hour_wday.R: 10 most frequent starting/ending stations during weekday rush hour (Step 2.1 in plan)
- Wknd_10stations.R: 10 most frequent start/end stations during weekends (Step 3 in plan)
- Average_Utilization.R: average utilization of bikes for each month (total time used/total time in month) (Step 4 in plan)
