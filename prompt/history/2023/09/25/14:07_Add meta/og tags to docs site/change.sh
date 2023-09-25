#!/bin/sh
set -e

goal="Add meta/og tags to docs site"
echo "Plan:"
echo "1. Update index.html to add meta/og tags."
echo "2. Use content from README.md for title and description."
echo "3. Use video_cover.jpg from README.md as og:image."

cat > ./docs/index.html << 'EOF'
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

  <!-- Open Graph tags -->
  <meta property="og:title" content="Junior - Your AI-first IDE">
  <meta property="og:description" content="Junior is an AI-first IDE designed specifically for professional programmers. By using structured task descriptors and spotlighting relevant parts of a project, tasks like code implementation, documentation, and testing can be seamlessly delegated to Junior.">
  <meta property="og:image" content="/assets/video_cover.jpg">
  <meta property="og:url" content="https://aijunior.dev">

</head>
<body>
  <div id="app"></div>
  <script src="docsifyConfig.js"></script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"