# BTC1855_Midterm

Plan
1. EDA.R --- EDA on trips.csv and weather.csv

2. Find out number of cancelled trips (starting and ending at same station, duration <3 mins), record trip ids, remove from dataset

3. Identify outliers, record these trip ids, remove from dataset

4. Find hours of weekdays where trip volume is highest (i.e. rush hours)

  4.1. 10 most frequent starting/ending stations during rush hours

5. 10 most frequent start/end stations during weekends

6. Average utilization of bikes for each month (total time used/total time in month)

7. Create new dataset combiing trip and weather data
  7.1. create correlation matric cor() and flag highest       correlations for team