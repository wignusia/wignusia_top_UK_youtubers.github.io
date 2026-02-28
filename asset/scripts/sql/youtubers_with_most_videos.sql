/* 
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/

-- 1.
DECLARE @conversionRate FLOAT = 0.02;           -- The conversion rate @ 2%
DECLARE @productCost FLOAT = 8.5;               -- The product cost @ PLN 8.5 
DECLARE @campaignCostPerVideo FLOAT = 4500.0;   -- The campaign cost per video @ PLN 4,500
DECLARE @numberOfVideos INT = 10;               -- The number of videos (10)

-- 2.
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM
        view_top_youtube_poland_2024
)

-- 3.
SELECT
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - (@campaignCostPerVideo * @numberOfVideos)) AS net_profit
FROM
    ChannelData

-- 4.
WHERE
    channel_name IN ('tvnpl', 'TVN Series','Polsat','JASNA STRONA','Admiros')

-- 5.
ORDER BY
    net_profit DESC;