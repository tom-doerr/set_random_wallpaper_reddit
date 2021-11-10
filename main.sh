#!/bin/bash

wallpaper_id=$1

# Get the list of all links to images from the front page of the Wallpapers subreddit.
wget -qO- https://www.reddit.com/r/wallpapers/top.json?limit=100 | jq -r '.data.children[].data.url' | grep -Eo 'https://i.redd.it/.*' > urls.txt


if [ -z "$wallpaper_id" ]; then
    # Select random entry from urls.txt.
    url=$(shuf -n 1 urls.txt)
else
    # Check if wallpaper_id is valid.
    if [ "$wallpaper_id" -gt "$(wc -l urls.txt | cut -d' ' -f1)" ]; then
        exit 1
    fi
    url=$(cat urls.txt | grep -Eo 'https://i.redd.it/.*' | head -n $wallpaper_id | tail -n 1)
fi


# Download the image.
wget -q "$url" -O /tmp/wallpaper.jpg

# Set the wallpaper.
#feh --bg-fill /tmp/wallpaper.jpg
feh --bg-fill --no-xinerama /tmp/wallpaper.jpg

# Save the url and the image to a folder in the home directory.
mkdir -p ~/Pictures/Wallpapers/i.redd.it/
echo "$url" >> ~/Pictures/Wallpapers/url.txt
mv /tmp/wallpaper.jpg ~/Pictures/Wallpapers/

target_path=~/Pictures/Wallpapers/$(echo "$url" | grep -Eo 'i.redd.it/[^/]*') 
mv ~/Pictures/Wallpapers/wallpaper.jpg $target_path
ln -sf $target_path ~/Pictures/Wallpapers/current
rm urls.txt

