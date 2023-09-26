#!/bin/sh
set -e
goal="Make Junior app installable without caching"
echo "Plan:"
echo "1. Add a web app manifest to describe the app."
echo "2. Create a minimal service worker without caching."
echo "3. Link the web app manifest and service worker to the index.html."

# Step 1: Adding web app manifest
cat > ./src/frontend/manifest.json << 'EOF'
{
  "name": "Junior",
  "short_name": "Junior",
  "description": "AI-first IDE for developers",
  "display": "standalone",
  "start_url": "/",
  "background_color": "#ffffff",
  "theme_color": "#000000",
  "icons": [
    {
      "src": "/assets/favicon.ico",
      "sizes": "64x64",
      "type": "image/x-icon"
    }
  ]
}
EOF

# Step 2: Creating a minimal service worker
cat > ./src/frontend/service-worker.js << 'EOF'
self.addEventListener('install', (event) => {
  // Service worker installed
});
EOF

# Step 3: Linking to index.html
cat > ./src/frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="manifest" href="/manifest.json">
  <link rel="icon" href="/assets/favicon.ico" type="image/x-icon">
  <link href="https://unpkg.com/prism-themes@1.9.0/themes/prism-holi-theme.min.css" rel="stylesheet" />
  <title>Junior</title>
</head>
<body>
  <div id="app" class="bg-emphasize"></div>
  <script type="module" src="/index.jsx"></script>
  <script src="https://unpkg.com/prismjs@v1.x/components/prism-core.min.js"></script>
  <script src="https://unpkg.com/prismjs@v1.x/plugins/autoloader/prism-autoloader.min.js"></script>
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', () => {
        navigator.serviceWorker.register('/service-worker.js');
      });
    }
  </script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"