import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

load_dotenv()

API_KEY = os.getenv("YOUTUBE_API_KEY")
API_VERSION = 'v3'

youtube = build('youtube', API_VERSION, developerKey=API_KEY)
def get_channel_stats(youtube, channel_id):
    try:
        request = youtube.channels().list(
            part='snippet, statistics',
            id=channel_id
        )
        response = request.execute()

        items = response.get('items', [])

        if items:
            data = dict(
                channel_id=channel_id,
                channel_name=items[0]['snippet']['title'],
                total_subscribers=items[0]['statistics'].get('subscriberCount', 0),
                total_views=items[0]['statistics'].get('viewCount', 0),
                total_videos=items[0]['statistics'].get('videoCount', 0),
            )
            return data
        else:
            print(f"Brak danych dla ID: {channel_id}")
            return None

    except Exception as e:
        print(f"Wystąpił błąd przy kanale {channel_id}: {e}")
        return None


# --- Data Processing ---

# Load the source CSV into a DataFrame
df = pd.read_csv("youtube_data_poland.csv")

# Extract channel_id by splitting the 'NAME' column and removing duplicates
df[['channel_name', 'channel_id']] = df['NAME'].str.split('@', expand=True)
channel_ids=df['channel_id'].unique()

# Initialize a list to keep track of channel stats
channel_stats = []

# Loop over the channel IDs and get statistics for each
for channel_id in channel_ids:
    stats = get_channel_stats(youtube, channel_id)
    if stats is not None:
        channel_stats.append(stats)

print('Processing complete.')

# Convert the results list into a new DataFrame
stats_df = pd.DataFrame(channel_stats)

# Clean channel IDs to ensure a successful merge
df['channel_id'] = df['channel_id'].str.strip()
stats_df['channel_id'] = stats_df['channel_id'].str.strip()

# Merge statistics back into the original DataFrame using a Left Join
# This ensures we keep all original rows even if API data is missing
merged_df = pd.merge(df, stats_df, on='channel_id', how='left')

# Save the final merged dataset to a new CSV file
# merged_df is the final version of the enriched dataset
merged_df.to_csv('updated_youtube_polandv3.csv', index=False)

print(f"Processing complete. Data saved to: {merged_df}")
print("-" * 30)
print(f"\n Processing complete!")
print(f"Total channels processed: {len(channel_ids)}")
print(f"Data successfully exported to: {merged_df}")
print("-" * 30)