#!/bin/sh
set -e
goal="Generate logo, favicon, and update HTML"
echo "Plan:"
echo "1. Generate a logo with four rounded rectangles"
echo "2. Save the logo to doc/assets/logo.png"
echo "3. Create a favicon based on the logo"
echo "4. Create the directory src/frontend/assets/ if not exists"
echo "5. Save the favicon to src/frontend/assets/"
echo "6. Update src/frontend/index.html to use the favicon"

# Step 1 & 2: Generate and save the logo
convert -size 100x100 xc:white \
    -fill "rgb(59, 130, 246)" -draw "roundrectangle 0,0 100,24 10,10" \
    -fill "rgb(253, 186, 116)" -draw "roundrectangle 0,26 100,49 10,10" \
    -fill "rgb(185, 28, 28)" -draw "roundrectangle 0,51 100,74 10,10" \
    -fill "rgb(28, 185, 28)" -draw "roundrectangle 0,76 100,100 10,10" \
    doc/assets/logo.png

# Step 4: Create the directory if not exists
mkdir -p src/frontend/assets/

# Step 3: Create favicon
convert doc/assets/logo.png -resize 32x32 src/frontend/assets/favicon.ico

# Step 6: Update index.html to use the favicon
cat > src/frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="icon" href="/assets/favicon.ico" type="image/x-icon">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/index.jsx"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"
