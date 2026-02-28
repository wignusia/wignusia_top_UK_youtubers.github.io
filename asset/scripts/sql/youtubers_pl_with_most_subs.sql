/* 

# 1. Define variables 
# 2. Create a CTE that rounds the average views per video 
# 3. Select the column you need and create calculated columns from existing ones 
# 4. Filter results by Youtube channels
# 5. Sort results by net profits (from highest to lowest)

*/

-- 1. 
DECLARE @conversionRate FLOAT = 0.02;		-- The conversion rate @ 2%
DECLARE @productCost FLOAT = 8.5;			-- The product cost @ PLN 8.5
DECLARE @campaignCost FLOAT = 40000.0;		-- The campaign cost @  PLN 40,000	

-- 2.  
WITH ChannelData AS (
    SELECT 
        channel_name,
        total_views,
        total_videos,
        ROUND(CAST(total_views AS FLOAT) / NULLIF(total_videos,0), -4) AS rounded_avg_views_per_video
    FROM 
        view_top_youtube_poland_2024
)

-- 3. 
SELECT 
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM 
    ChannelData

-- 4. 
WHERE 
    channel_name in ('Bazylland - Tractors & Excavators', 'WB Kids International', 'reZigiusz' )
 
-- 5.  
ORDER BY
	     net_profit DESC