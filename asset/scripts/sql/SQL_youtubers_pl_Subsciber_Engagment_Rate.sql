/*
Compare DAX and Power BI calculations for consistency; implement the RANK function for 'Subscriber Engagement Rate'.
*/

WITH Channel_Subscribes_Engagment_Rate AS (
    
     SELECT
        channel_name as Channel_Name, 
        NULLIF(total_subscribers,0)/total_videos as Subscribes_Engagment_Rate
    FROM 
        view_top_youtube_poland_2024
    )
 SELECT 
        TOP 3    
         ROW_NUMBER() OVER (Order by Subscribes_Engagment_Rate DESC) as Rank,
        *
 FROM   Channel_Subscribes_Engagment_Rate
        
 Order BY 
        Subscribes_Engagment_Rate    DESC