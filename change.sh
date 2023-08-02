#!/bin/sh
set -e
goal="Implement roadmap, fix index.html, delete files and build docs"
echo "Plan:"
echo "1. Create the roadmap.md file with required sections"
echo "2. Create roadmap.html file and link it from index.html"
echo "3. Fix the misplaced link in index.html"
echo "4. Modify index.html to mention the project name 'Junior'"
echo "5. Delete introduction.html and introduction.md"
echo "6. Remove the link to introduction.html from index.html"
echo "7. Execute npm run build:doc to generate HTML from Markdown"

# Step 1
cat << 'EOF' > ./doc/roadmap.md
# Roadmap
## Usability & fixes
- Details here

## Programming on mobile
- Details here

## Auto-attention
- Details here

## Prompt-herd refactors
- Details here
EOF

# Step 2
cat << 'EOF' > ./doc/index.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Junior Documentation</title>
  </head>
  <body>
    <h1>Welcome to Junior Documentation!</h1>
    <p>Check out the <a href="web.html">Web Interface Guide</a>.</p>
    <p><a href="roadmap.html">Roadmap</a></p>
  </body>
</html>
EOF

# Step 3, 4, 5, and 6 are addressed in the above heredoc

# Step 5
rm ./doc/introduction.html ./doc/introduction.md

# Step 7
npm run build:doc

echo "\033[32mDone: $goal\033[0m\n"
