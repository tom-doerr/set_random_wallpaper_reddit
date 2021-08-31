#!/bin/bash

# Download a random wallpaper image.

# Get the list of all links to images from the front page of the Wallpapers subreddit.
# wget -qO- https://www.reddit.com/r/wallpapers/top.json?limit=100 | jq -r '.data.children[].data.url' | grep -Eo 'https://i.redd.it/.*' > urls.txt

# Download the image.
# wget -q "$(head -n 1 urls.txt)" -O /tmp/wallpaper.jpg

# Set the wallpaper.
# feh --bg-fill /tmp/wallpaper.jpg

# Delete the image.
# rm /tmp/wallpaper.jpg

# Get the list of all links to images from the front page of the Wallpapers subreddit.
wget -qO- https://www.reddit.com/r/wallpapers/top.json?limit=100 | jq -r '.data.children[].data.url' | grep -Eo 'https://i.redd.it/.*' > urls.txt

# Select random entry from urls.txt.
url=$(shuf -n 1 urls.txt)

# Download the image.
wget -q "$url" -O /tmp/wallpaper.jpg

# Set the wallpaper.
#feh --bg-fill /tmp/wallpaper.jpg
feh --bg-fill --no-xinerama /tmp/wallpaper.jpg

# Save the url and the image to a folder in the home directory.
mkdir -p ~/Pictures/Wallpapers/i.redd.it/
echo "$url" >> ~/Pictures/Wallpapers/url.txt
mv /tmp/wallpaper.jpg ~/Pictures/Wallpapers/
# Rename the image to the url name.
mv ~/Pictures/Wallpapers/wallpaper.jpg ~/Pictures/Wallpapers/$(echo "$url" | grep -Eo 'i.redd.it/[^/]*')
rm urls.txt

