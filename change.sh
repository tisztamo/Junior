#!/bin/sh
set -e
goal="Generate favicon from logo and add to HTML"
echo "Plan:"
echo "1. Convert the logo.png to favicon.ico"
echo "2. Update the index.html file to include the favicon"

# Step 1: Convert the logo.png to favicon.ico
convert docs/assets/logo.png -resize 16x16 docs/assets/favicon.ico

# Step 2: Update the index.html file to include the favicon
cat > docs/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="icon" href="assets/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/lib/themes/vue.css">
</head>
<body>
  <style>
    .app-name-link img {
      max-width: 70px;
    }
  </style>
  <div id="app"></div>
  <script src="docsifyConfig.js"></script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"
