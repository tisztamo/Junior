#!/bin/sh
set -e
goal="Improve documentation and embed video"
echo "Plan:"
echo "1. Create a doc/assets directory."
echo "2. Download video cover image with curl."
echo "3. Compress the image to be less than 30K."
echo "4. Add a markdown link to the README.md that points to the Youtube video."
echo "5. Add a caption to the image."

mkdir -p doc/assets

curl -o doc/assets/video_cover.jpg "https://img.youtube.com/vi/W_iwry8uT7E/maxresdefault.jpg"

# Compress the image using ffmpeg
ffmpeg -i doc/assets/video_cover.jpg -vf "scale=iw*0.5:ih*0.5" -compression_level 9 doc/assets/compressed_video_cover.jpg

mv doc/assets/compressed_video_cover.jpg doc/assets/video_cover.jpg

sed -i '' '/# Junior - Your AI contributor which writes itself./a\
\
[![Video: Junior codes itself](doc/assets/video_cover.jpg)](https://www.youtube.com/watch?v=W_iwry8uT7E)\
*"Video: Junior codes itself"*' README.md

echo "\033[32mDone: $goal\033[0m\n"
