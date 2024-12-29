#!/bin/sh
set -e
goal="Integrate Twitter blockquote in docs sidebar"
echo "Plan:"
echo "1. Backup the original _sidebar.md file for safety."
echo "2. Append the Twitter blockquote to the _sidebar.md in the docs directory."

# 1. Backup the original _sidebar.md file for safety.
cp ./docs/_sidebar.md ./docs/_sidebar_backup.md

# 2. Append the Twitter blockquote to the _sidebar.md in the docs directory.
cat >> ./docs/_sidebar.md << 'EOF'

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">After 34 years of daily CODING, I STOPPED and now only write software in ENGLISH with the Junior AI IDE. So much powerful than naked ChatGPT. <a href="https://t.co/MD1G1kIQte">https://t.co/MD1G1kIQte</a> <a href="https://twitter.com/hashtag/AI?src=hash&amp;ref_src=twsrc%5Etfw">#AI</a> <a href="https://twitter.com/hashtag/development?src=hash&amp;ref_src=twsrc%5Etfw">#development</a> <a href="https://twitter.com/hashtag/JuniorIDE?src=hash&amp;ref_src=twsrc%5Etfw">#JuniorIDE</a> <a href="https://twitter.com/hashtag/ChatGPT?src=hash&amp;ref_src=twsrc%5Etfw">#ChatGPT</a></p>&mdash; Krisztián Schäffer (@tisztamo_x) <a href="https://twitter.com/tisztamo_x/status/1693697665937166701?ref_src=twsrc%5Etfw">August 21, 2023</a></blockquote>
EOF

echo "\033[32mDone: $goal\033[0m\n"