#!/bin/sh
set -e
goal="Move script from sidebar to index.html"
echo "Plan:"
echo "1. Remove script tag from docs/_sidebar.md"
echo "2. Add script tag to docs/index.html"

# 1. Remove script tag from docs/_sidebar.md
cat > docs/_sidebar.md << 'EOF'
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">After 34 years of daily CODING, I STOPPED and now only write software in ENGLISH with the Junior AI IDE. So much powerful than naked ChatGPT. <a href="https://t.co/MD1G1kIQte">https://t.co/MD1G1kIQte</a> <a href="https://twitter.com/hashtag/AI?src=hash&amp;ref_src=twsrc%5Etfw">#AI</a> <a href="https://twitter.com/hashtag/development?src=hash&amp;ref_src=twsrc%5Etfw">#development</a> <a href="https://twitter.com/hashtag/JuniorIDE?src=hash&amp;ref_src=twsrc%5Etfw">#JuniorIDE</a> <a href="https://twitter.com/hashtag/ChatGPT?src=hash&amp;ref_src=twsrc%5Etfw">#ChatGPT</a></p>&mdash; Krisztián Schäffer (@tisztamo_x) <a href="https://twitter.com/tisztamo_x/status/1693697665937166701?ref_src=twsrc%5Etfw">August 21, 2023</a></blockquote>
EOF

# 2. Add script tag to docs/index.html
cat > docs/index.html << 'EOF'
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
  <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"