/*
Data Cleaning Steps:
1. Remove unnecessary columns by selecting only the required fields.
2. Extract clean YouTube channel names from the source string.
3. Handle NULL values in metrics using the COALESCE function to ensure calculation stability.
4. Rename columns for better readability and alignment with project standards.
5. Updated the data type of the channel_name column from VARCHAR to NVARCHAR to support Unicode (Cyrillic) characters.

*/

CREATE VIEW view_top_youtube_poland_2024 AS

Select 
	CAST(SUBSTRING(NAME, 1,CHARINDEX('@', NAME)-1) AS NVARCHAR(100)) AS channel_name, 
	COALESCE(total_subscribers, 0) AS total_subscribers,
    COALESCE(total_views, 0) AS total_views,
    COALESCE(total_videos, 0) AS total_videos
From 
	top_youtube_poland_2024