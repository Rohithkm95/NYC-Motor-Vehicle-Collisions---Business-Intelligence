--Metrics
--number of collisions
use Motor
SELECT COUNT(collision_id) AS [number of collisions]
FROM [dbo].[fct_collision_crashes];

--number of people injured or died
SELECT SUM(number_of_persons_injured) AS injured, SUM(number_of_persons_killed) AS died
FROM [dbo].[fct_collision_crashes];

--number of people by role, such as pedestrian, injured or died
SELECT SUM(number_of_cyclist_injured) AS [cyclist injured], 
        SUM(number_of_cyclist_killed) AS [cyclist died],
        SUM(number_of_motorist_injured) AS [motorist injured], 
        SUM(number_of_motorist_killed) AS [motorist died],
        SUM(number_of_pedestrians_injured) AS [pedestrians injured], 
        SUM(number_of_pedestrians_killed) AS [pedestrians died],
        SUM(number_of_persons_killed) AS [persons died]
FROM [dbo].[fct_collision_crashes];

--number of vehicles involved
SELECT SUM(number_of_vehicles_involved) AS [number of vehicles]
FROM [dbo].[fct_collision_crashes];

--Dimensions
--Annual statistics
SELECT VEHICLE_YEAR AS years,COUNT(COLLISION_ID) AS [number of collisions]
FROM [dbo].[fct_Collisions_Vehicles]
WHERE VEHICLE_YEAR>2000 AND VEHICLE_YEAR<2023
GROUP BY VEHICLE_YEAR
ORDER BY VEHICLE_YEAR


--Time of day
SELECT collision_hour, COUNT(collision_id) AS [numbers of people]
FROM [dbo].[fct_collision_crashes]
GROUP BY collision_hour
ORDER BY collision_hour

--Vehicle types
SELECT dvt.VEHICLE_TYPE, COUNT(fcv.COLLISION_ID) AS [numbers of vehicle]
FROM [dbo].[fct_Collisions_Vehicles] fcv INNER JOIN [dbo].[Dim_VEHICLE_TYPE] dvt ON fcv.VEHICLE_TYPE_SK = dvt.VEHICLE_TYPE_SK
GROUP BY dvt.VEHICLE_TYPE;

--Collision causes
SELECT dim.CONTRIBUTING_FACTOR, COUNT(fct.UNIQUE_ID) AS numbers
FROM [dbo].[fct_Collisions_Vehicles_Contributing_Factors] fct INNER JOIN [dbo].[Dim_CONTRIBUTING_FACTOR] dim ON fct.CONTRIBUTING_FACTOR_SK = DIM.CONTRIBUTING_FACTOR_SK
GROUP BY dim.CONTRIBUTING_FACTOR;

--Collision Analysis
SELECT dim.CONTRIBUTING_FACTOR, COUNT(fct.UNIQUE_ID) AS numbers
FROM [dbo].[fct_Collisions_Vehicles_Contributing_Factors] fct INNER JOIN [dbo].[Dim_CONTRIBUTING_FACTOR] dim ON fct.CONTRIBUTING_FACTOR_SK = DIM.CONTRIBUTING_FACTOR_SK
GROUP BY dim.CONTRIBUTING_FACTOR
ORDER BY numbers DESC;

--Time Series Analysis
--analysis by hour
SELECT collision_hour, COUNT(collision_id) AS [numbers of people]
FROM [dbo].[fct_collision_crashes]
GROUP BY collision_hour
ORDER BY [numbers of people] DESC;

--analysis by day of the week
SELECT collision_dayoftheweek AS WeekDays, COUNT(collision_id) AS [numbers of people]
FROM [dbo].[fct_collision_crashes]
GROUP BY collision_dayoftheweek
ORDER BY [numbers of people] DESC;

--Fatality Analysis
SELECT SUM(number_of_cyclist_injured) AS [cyclist injured], 
        SUM(number_of_cyclist_killed) AS [cyclist died],
        SUM(number_of_motorist_injured) AS [motorist injured], 
        SUM(number_of_motorist_killed) AS [motorist died],
        SUM(number_of_pedestrians_injured) AS [pedestrians injured], 
        SUM(number_of_pedestrians_killed) AS [pedestrians died],
        SUM(number_of_persons_killed) AS [persons died]
FROM [dbo].[fct_collision_crashes];


--Which Boroughs in New York City Have the Most Accidents?
SELECT borough, COUNT(collision_id) AS [times]
FROM [dbo].[fct_collision_crashes]
GROUP BY borough
ORDER BY [times] DESC;

--How Many NYC Car Accidents Result in an Injury?
SELECT COUNT(collision_id) AS [times]
FROM [dbo].[fct_collision_crashes]
where number_of_cyclist_injured > 0 OR
        number_of_motorist_injured > 0 OR
        number_of_pedestrians_injured > 0;

--Which NYC Borough Has the Most Fatal Car Accidents?
SELECT borough, COUNT(collision_id) AS [times]
FROM [dbo].[fct_collision_crashes]
where (number_of_cyclist_killed > 0 OR
        number_of_motorist_killed > 0 OR
        number_of_pedestrians_killed > 0 OR
        number_of_persons_killed > 0) AND
		borough IS NOT NULL
GROUP BY borough
ORDER BY [times] DESC;

--When Do Most New York City Car Accidents Happen?
SELECT collision_hour, COUNT(collision_id) AS [numbers of people]
FROM [dbo].[fct_collision_crashes]
GROUP BY collision_hour
ORDER BY COUNT(collision_id) 

--How Common Are Bicycle Accidents in NYC?
SELECT COUNT(c.collision_id) AS [times]
FROM [dbo].[fct_collision_crashes] c
LEFT OUTER JOIN [dbo].[fct_Collisions_Vehicles] v
ON c.collision_id = v.COLLISION_ID
LEFT OUTER JOIN dbo.Dim_VEHICLE_TYPE vt
ON v.VEHICLE_TYPE_SK = vt.VEHICLE_TYPE_SK
where vt.VEHICLE_TYPE = 'BICYCLE'


--How Many Motorcyclists are Injured or Killed in NYC Accidents?
SELECT SUM(number_of_motorist_injured) + SUM(number_of_motorist_killed) AS people
FROM [dbo].[fct_collision_crashes];

--Are Trucks Involved in Many New York Accidents?
SELECT COUNT(fcv.COLLISION_ID) AS [numbers of Trucks Involved]
FROM [dbo].[fct_Collisions_Vehicles] fcv LEFT OUTER JOIN [dbo].[Dim_VEHICLE_TYPE] dvt ON fcv.VEHICLE_TYPE_SK = dvt.VEHICLE_TYPE_SK
WHERE dvt.VEHICLE_TYPE = 'TRUCK';