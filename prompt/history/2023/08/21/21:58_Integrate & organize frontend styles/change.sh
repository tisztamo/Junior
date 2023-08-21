#!/bin/sh
set -e
goal="Integrate & organize frontend styles"
echo "Plan:"
echo "1. Create a new CSS file within the 'assets' directory named 'styles.css' to hold global styles."
echo "2. Move the existing inline styles from 'docs/index.html' to the new CSS file."
echo "3. Add the required margin styles for iframes in the new CSS file."
echo "4. Modify the 'docs/index.html' file to include the new CSS file."

# Step 1: Create a new CSS file within the 'assets' directory named 'styles.css' to hold global styles.
touch ./docs/assets/styles.css

# Step 2: Move the existing inline styles from 'docs/index.html' to the new CSS file.
cat > ./docs/assets/styles.css <<EOF
.app-name-link img {
  max-width: 70px;
}

iframe {
  margin: 16px;
}
EOF

# Step 3: Already covered as we added the iframe styles in the step above.

# Step 4: Modify the 'docs/index.html' file to include the new CSS file.
cat > ./docs/index.html <<EOF
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
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
  <div id="app"></div>
  <script src="docsifyConfig.js"></script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"