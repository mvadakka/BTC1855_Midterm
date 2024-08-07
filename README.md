# BTC1855_Midterm
#Plan
1. EDA.R ---> Perform EDA on trips.csv and weather.csv. Remove NA/missing values. Factor categorical variables. Identify and remove cancelled trips. Identify and remove outliers

2. Highest_volume.R --->  Find hours of weekdays where trip volume is highest (i.e. rush hours)

2.1. Rush_hour_wday.R --> Find 10 most frequent starting/ending stations during weekday rush hours

3. Wknd_10stations.R --> Find 10 most frequent start/end stations during weekends

4. Average_Utilization.R ---> Determine the average utilization of bikes for each month (total time used/total time in a month)

5. weather.trips.R --> Create new dataset combining trip and weather data. Create correlation matrix cor() and flag the highest correlations for team
  
#Dictionary of folders:
- EDA plots - plots generated during EDA process
- csv - csv files generated across steps

#Dictionary of files:
- EDA.R: EDA R script (Step 1 in Plan)
- removed.weather: removed missing data from weather.csv, specifically in the precipitation_inches, max_gust_speed_mph, max_visibility_miles and max_gust_speed_mph columns
- removed.trips: removed canceled data and outliers from trip.csv
- Highest_volume.R: Script to determine hours of weekdays where trip volume is highest and plot (Step 2)
- highest_volumehours.csv: csv file of frequency of trips per hour, per weekday, arranged by greatest frequency to least
- Rush_hour_wday.R: 10 most frequent starting/ending stations during weekday rush hour (Step 2.1 in plan)
- Wknd_10stations.R: 10 most frequent start/end stations during weekends (Step 3 in plan)
- Average_Utilization.R: average utilization of bikes for each month (total time used/total time in a month) (Step 4 in plan)
- weather.trips.R: steps to creating new dataset combining trip and weather data, and creating a correlation matrix. Flagging highest correlations (Step 5 in plan)
- Midterm_Report.docx: Report with summary of data, removed values, and findings
