#!/bin/sh
set -e
goal="Configure docsify with sidebar and linked files"
echo "Plan:"
echo "1. Configure the window.$docsify object in index.html to use a sidebar."
echo "2. Create a _sidebar.md file in the docs directory that links to README.md, roadmap.md, and web.md."
echo "3. Delete example.md and screenshot.md."

# Step 1: Configure the window.$docsify object in index.html to use a sidebar.
cat > ./docs/index.html <<- 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/lib/themes/vue.css">
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      name: '',
      repo: '',
      loadSidebar: true
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
EOF

# Step 2: Create a _sidebar.md file in the docs directory that links to README.md, roadmap.md, and web.md.
cat > ./docs/_sidebar.md <<- 'EOF'
* [Home](./README.md)
* [Roadmap](./roadmap.md)
* [Web](./web.md)
EOF

# Step 3: Delete example.md and screenshot.md.
rm ./docs/example.md
rm ./docs/screenshot.md

echo "\033[32mDone: $goal\033[0m\n"
