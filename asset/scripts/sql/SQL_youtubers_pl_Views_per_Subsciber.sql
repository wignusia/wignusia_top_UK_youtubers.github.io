/*
Compare DAX and Power BI calculations for consistency; implement the RANK function for 'Views Per Subscriber'.

*/


WITH Channel_Viws_per_Subscribes AS (
    
     SELECT
        channel_name as Channel_Name, 
        total_views/NULLIF(total_subscribers,0) as Viws_per_Subscribes
    FROM 
        view_top_youtube_poland_2024
    )
 SELECT 
        TOP 3    
         ROW_NUMBER() OVER (Order by Viws_per_Subscribes DESC) as Rank,
        *
 FROM
        Channel_Viws_per_Subscribes
 Order BY 
        Viws_per_Subscribes    DESC
    
 