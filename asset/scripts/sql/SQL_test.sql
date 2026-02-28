/*

# Data Quality Tests

1.The dataset must contain exactly 100 YouTube channels (100 records)												----(passed !!!)
2.The dataset must include 4 fields (columns).																		----(passed !!!)
3.The channel_name column must be in string format, and the remaining columns must be numeric (data type check).    ----(passed !!!)
4.Each record in the dataset must be unique (duplicate check).														----(passed !!!)
5.No record should contain NULL values (null check).																----(passed !!!)
6.The channel_name column should not contain special characters such as '*', '?', '/', '!', '#'."					----(passed !!!)


Row count: 100  
Column count: 4  

Data types:  
- channel_name = NVARCHAR   (UPDATE from VARCHAR to NVARCHAR)
- total_subscribers = INTEGER  
- total_views = INTEGER  
- total_videos = INTEGER  

Duplicate count: 0  
Null values: 0

*/

--- 1.Row count check
SELECT 
	Count(*) no_of_rows
FROM 
	view_top_youtube_poland_2024


--- 2. Column count check 
SELECT 
	COUNT (*) as  column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_top_youtube_poland_2024'


--- 3. Data type check

SELECT 
	  COLUMN_NAME,
	  DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE	
	TABLE_NAME = 'view_top_youtube_poland_2024'


--- 4. Duplicate check

SELECT 
	channel_name,
	COUNT(*)as duplica_check
FROM 
	view_top_youtube_poland_2024
GROUP BY 
	channel_name
HAVING 
	COUNT(*) >1


--- 5. null check

SELECT 
	COUNT(*) AS null_count,
	CASE 
        WHEN COUNT(*) = 0 THEN 'PASSED' 
        ELSE 'FAILED' 
    END AS test_status
FROM 
	view_top_youtube_poland_2024
WHERE	
	 total_subscribers IS NULL
	 OR total_views IS NULL
	 OR total_videos IS NULL;

--- 6. invidal chanle_name  check 
SELECT 
	channel_name
FROM 
	view_top_youtube_poland_2024
WHERE 
		channel_name LIKE '%?%' or
		channel_name LIKE '%!%' or
		channel_name LIKE '%/%' or
		channel_name LIKE '%*%' or
		channel_name LIKE '%#%' 