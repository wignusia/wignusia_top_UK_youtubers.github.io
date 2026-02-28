/*
Compare DAX and Power BI calculations for consistency; implement the RANK function for ' Average Views Per Video'.
*/

 With Channel_Agv_Views_Per_Video as 
 (
        SELECT 
         channel_name as Channel_Name,
         ROUND(CAST (total_views AS FLOAT) / NULLIF(total_videos, 0),-4) AS Avg_Views_Per_Video_M 
        FROM view_top_youtube_poland_2024
   )

SELECT 
    TOP 3
    ROW_NUMBER() OVER ( ORDER BY  Avg_Views_Per_Video_M DESC  ) as Rank,
    *
From 
    Channel_Agv_Views_Per_Video
 ORDER BY  
      Avg_Views_Per_Video_M DESC 