#!/bin/sh
set -e
goal="Create favicon.ico from logo.png"
echo "Plan:"
echo "1. Use convert utility to convert logo.png to favicon.ico"
echo "2. Move the converted favicon.ico to the appropriate location"

# convert logo.png to favicon.ico
convert ./docs/assets/logo.png -resize 32x32 ./src/frontend/assets/favicon.ico

echo "\033[32mDone: $goal\033[0m\n"
