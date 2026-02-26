# # Data Portfolio: Excel to Power BI 
![kaggle_to_powerbi.png](asset/images/kaggle_to_powerbi.png)

🏗️ Under Construction:


"I am currently enhancing this project by integrating advanced Power BI techniques, refined Excel configurations, and Python scripts for automated data processing. My focus is on elevating the visual storytelling and ensuring the technical architecture is robust and scalable."
😀😀😀

#Tabel of Concepts
--------
## Objective

### What is the key pain point?

The Head of Marketing wants to identify the top YouTubers in Poland in 2024 to determine which creators would be the most suitable for marketing campaigns throughout the rest of the year.
The dashboard integrates real-time 2026 data via the YouTube API to ensure up-to-date performance metrics.

### What is the ideal solution?

To create a dashboard that provides insights into the top Polish YouTubers in 2024, including:

- Subscriber count  
- Total views  
- Total videos  
- Engagement metrics  

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

#User story
As the Head of Marketing, I want to identify the top YouTubers in Poland based on subscriber count, videos uploaded and views accumulated, so that I can decide on which channels would be best to run marketing campaigns with to generate a good ROI. 

# Data Source

### What data is needed to achieve our objective?
We need data on the top YouTubers in Poland for 2024, including their:
* **Channel names**
* **Total subscribers**
* **Total views**
* **Total videos uploaded**

### Where is the data coming from? 
The data is sourced from **Kaggle** (via an Excel extract). You can find the original dataset here: [Kaggle YouTube Dataset](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download).

> **Note:** This project uses the 2024 Kaggle dataset as the baseline list of YouTube channels. Performance metrics—such as subscribers, views, and video counts—are dynamically updated using real-time **2026 data** fetched via the **YouTube API**.

## Stages

* **Design**
* **Development**
* **Testing**
* **Analysis**

## Dashboard Components Required

### What should the dashboard contain?
To determine the layout and functionality, the dashboard must answer the following key business questions:

- [ ] Who are the **top 10 YouTubers** with the most subscribers?
- [ ] Which **3 channels** have uploaded the most videos?
- [ ] Which **3 channels** have the most views?
- [ ] Which **3 channels** have the highest **average views** per video?
- [ ] Which **3 channels** have the highest **views per subscriber** ratio?
- [ ] Which **3 channels** have the highest **subscriber engagement rate** per video uploaded?

## Dashboard Mockup

### What should it look like?
To effectively answer our key questions, the dashboard will incorporate several data visualizations. The following components have been identified as appropriate for this project:

* **Table** – For detailed breakdowns of YouTuber metrics.
* **Treemap** – To visualize the distribution of subscribers or views across different categories.
* **Scorecards** – For high-level "at a glance" KPIs (e.g., total subscribers, total views).
* **Horizontal Bar Chart** – Ideal for ranking the top 10 channels and comparing performance.

![dashboard_mockup.png](asset/images/dashboard_mockup.png)

## Tools

| Tool | Purpose |
| :--- | :--- |
| **Excel** | Initial data exploration and quick profiling. |
| **Python** | Fetching real-time data from the YouTube API. |
| **SQL Server** | Cleaning, testing, and performing in-depth data analysis. |
| **Power BI** | Visualizing the data through interactive dashboards. |
| **GitHub** | Project documentation hosting and version control. |
| **Canva** | Designing the high-fidelity mockup of the dashboard. |
| **Gemini AI** | Technical writing, code optimization, and documentation support. |

----
## Development

### Pseudocode

**What is the general approach in creating this solution from start to finish?**

1. **Get the Data** – Identify and collect the baseline dataset.
2. **Data Acquisition & Exploration** – Explore the data in **Excel** and fetch real-time metrics via the **YouTube API**.
3. **Data Ingestion** – Load the raw data into **SQL Server**.
4. **Data Cleaning** – Refine and format the data using **SQL** to ensure accuracy.
5. **Data Testing** – Run quality checks and validation scripts in **SQL**.
6. **Data Visualization** – Build interactive dashboards in **Power BI**.
7. **Insight Generation** – Analyze the visuals to generate findings and key takeaways.
8. **Documentation** – Write the technical documentation and project commentary
9. **Deployment** – Publish the final project and documentation to **GitHub Pages**.

------
## Data Exploration Notes

**Initial Observations & Observations:**

* **Data Sufficiency** – The dataset contains at least 4 key columns required for the analysis, meaning no additional data from the client is needed at this stage.
* **Format Issues** – Channel IDs in the first column are prefixed with an `@` symbol; these need to be cleaned to extract proper channel names.
* **Language & Localization** – Some headers and cell values are in a foreign language. These need to be evaluated for relevance and translated or handled accordingly.
* **Redundancy** – The dataset contains more information than required. Irrelevant columns will be removed to streamline the analysis.

## Data Cleaning

### Overview
The aim is to refine the dataset to ensure it is structured, accurate, and ready for analysis. The cleaned data must be lean, containing only the essential information required to answer our business questions.

### Constraints & Requirements
The cleaned dataset should meet the following criteria:
* **Relevance** – Only essential columns are retained.
* **Data Typing** – All data types must be appropriate for their respective content.
* **Data Integrity** – No column should contain null values; every record must be complete.

**Dataset Summary:**
| Property | Description |
| :--- | :--- |
| **Number of Rows** | 100 |
| **Number of Columns** | 4 |

### Expected Schema
| Column Name | Data Type | Nullable |Changes|
| :--- | :--- | :--- |:--- |
| channel_name | VARCHAR | NO | <span style="color: #4B0082;">Changed data type from VARCHAR to NVARCHAR to enable full Unicode support.</span> |
| total_subscribers | INTEGER | NO | -|
| total_views | INTEGER | NO | -|
| total_videos | INTEGER | NO | -|

### Cleaning Steps
To shape the data into the desired format, the following steps will be executed:
1. **Column Selection** – Filter out unnecessary columns and retain only the four required fields.
2. **String Manipulation** – Extract clean YouTube channel names from the primary column (removing the `@` prefix and IDs).
3. **Data Refinement** – Rename columns using clear, descriptive aliases for better readability in the final dashboard.

## Data Transformation (SQL)

To clean and shape the data, I developed the following SQL script. This creates a view that filters necessary columns, handles data types, and ensures data integrity by managing NULL values.

```sql
/*
Data Cleaning Steps:
1. Remove unnecessary columns by selecting only the required fields.
2. Extract clean YouTube channel names from the source string.
3. Handle NULL values in metrics using the COALESCE function to ensure calculation stability.
4. Rename columns for better readability and alignment with project standards.
5. Updated the data type of the channel_name column from VARCHAR to NVARCHAR to support Unicode (Cyrillic) characters.
*/

CREATE VIEW view_top_youtube_poland_2024 AS
SELECT 
    CAST(SUBSTRING(NAME, 1, CHARINDEX('@', NAME) - 1) AS NVARCHAR(100)) AS channel_name,
    COALESCE(total_subscribers, 0) AS total_subscribers,
    COALESCE(total_views, 0) AS total_views,
    COALESCE(total_videos, 0) AS total_videos
FROM 
    top_youtube_poland_2024;
```
#Testing

| Check | Description | Status |
| :--- | :--- | :--- |
| **Row Count** | The dataset must contain exactly 100 records. | ✅ Passed |
| **Column Count** | The dataset must include exactly 4 fields. | ✅ Passed |
| **Data Types** | `channel_name` must be a string; other metrics must be numeric. | ✅ Passed |
| **Uniqueness** | Each record must be unique (no duplicates). | ✅ Passed |
| **Null Check** | No record should contain NULL values. | ✅ Passed |
| **Invidal chanle_name**|The channel_name column should not contain special characters such as '*', '?', '/', '!', '#' | ✅ Passed |


## SQL Query	

```sql
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
```

## Output
![screenshots_SQL_data_quality_checks.png](asset/images/screenshots_SQL_data_quality_checks.png)

# Data Type Issue:
### 1.Issue: Missing Data during API Import

**Problem:**
Data loss occurred during the API statistics import process.
![missing_id_values.png](asset/images/missing_id_values.png)

**Root Cause:**
The initial merge method used an **Inner Join**, which excluded rows where API data was missing or where the `channel_id` did not have a direct match. This resulted in the loss of 2 records.

**Solution:**
<span style="color: #4B0082;">**Implemented a Left Join in Python to ensure all original records are preserved.**</span>

```python
# Merge statistics back into the original DataFrame using a Left Join
# This ensures we keep all original rows even if API data is missing
merged_df = pd.merge(df, stats_df, on='channel_id', how='left')
```
![api_merge_success_100rows.png](asset/images/api_merge_success_100rows.png)

### 2. Issue: Unicode Support (Cyrillic Characters)

**Problem:**
Incorrect encoding of Cyrillic characters (e.g., `Софунья Шалунья`, `Готовим дома`) due to `VARCHAR` data type.

**Root Cause:**
The `channel_name` column used `VARCHAR`, which lacks full Unicode compatibility.

**Solution:**
<span style="color: #4B0082;">**Changed data type from VARCHAR to NVARCHAR to enable full Unicode support.**</span>

**Result:**
Multilingual channel names are now stored and displayed correctly.

![cyrillic_rendering_issue_(varchar_to_nvarchar).png](asset/images/cyrillic_rendering_issue_(varchar_to_nvarchar).png)

---

# Visualization
## Results
What does the dashboard look like?
![powerbi_dashboard_PL.gif](asset/images/powerbi_dashboard_PL.gif)

## DAX Measures

### 1. Total Subscribers (M)
Calculates the total number of subscribers across all channels, scaled to millions.
```dax
Total Subscribers (M) = 
VAR million = 1000000
VAR sumOfSubscribers = SUM(view_top_youtube_poland_2024[total_subscribers])
VAR totalSubscribers = DIVIDE(sumOfSubscribers, million)

RETURN totalSubscribers
```
### 2. Total Views (B)
Calculates the total number of views across all channels, scaled to billions and rounded to two decimal places.
```dax
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_top_youtube_poland_2024[total_views])
VAR totalViews = ROUND(sumOfTotalViews / billion, 2)

RETURN totalViews
```
### 3. Total Videos
Calculates the total number of videos uploaded by the YouTubers in the dataset.

```dax
Total Videos = 
VAR totalVideos = SUM(view_top_youtube_poland_2024[total_videos])

RETURN totalVideos
```

####  4. Average Views Per Video (M)
Calculates the average number of views per video, expressed in millions.

```dax
Average Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_top_youtube_poland_2024[total_views])
VAR sumOfTotalVideos = SUM(view_top_youtube_poland_2024[total_videos])
VAR avgViewsPerVideo = DIVIDE(sumOfTotalViews, sumOfTotalVideos, BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo
```

###  5. Subscriber Engagement Rate
Measures the relationship between the number of subscribers and the total number of videos produced.

```dax
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_top_youtube_poland_2024[total_subscribers])
VAR sumOfTotalVideos = SUM(view_top_youtube_poland_2024[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngRate
```

### 6. Views per Subscriber
Calculates the average number of views generated per individual subscriber.

```dax
Views Per Subscriber = 
VAR sumOfTotalViews = SUM(view_top_youtube_poland_2024[total_views])
VAR sumOfTotalSubscribers = SUM(view_top_youtube_poland_2024[total_subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews, sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber
```

----
 # Analysis
## Findings
What did we find?
For this analysis, we're going to focus on the questions below to get the information we need for our marketing client/boss :) 

Here are the key questions we need to answer for our marketing client:

1.Who are the top 10 YouTubers with the most subscribers?
2.Which 3 channels have uploaded the most videos?
3.Which 3 channels have the most views?
4.Which 3 channels have the highest average views per video?
5.Which 3 channels have the highest views per subscriber ratio?
6.Which 3 channels have the highest subscriber engagement rate per video uploaded?


 ### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name                         | Subscribers |
|:----:|:-------------------------------------|------------:|
| 1    | Bazylland - Tractors & Excavators    | 7 420 000   |
| 2    | WB Kids International                | 6 870 000   |
| 3    | reZigiusz                            | 5 400 000   |
| 4    | Blowek                               | 5 390 000   |
| 5    | Софунья Шалунья                      | 4 050 000   |
| 6    | Step Records                         | 4 040 000   |
| 7    | Boomerang Polska                     | 3 570 000   |
| 8    | SBM Label                            | 3 460 000   |
| 9    | AbstrachujeTV                        | 3 370 000   |
| 10   | IsAmU                                | 2 850 000   |

### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name | Videos Uploaded |
|:----:|:-------------|----------------:|
| 1    | tvnpl        | 20163           |
| 2    | TVN Series   | 13589           |
| 3    | Polsat       | 12077           |
