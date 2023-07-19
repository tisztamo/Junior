#!/bin/sh
# Goal: Rename project from "Contributor" to "Junior" and update system.md
# Plan:
# 1. Rename the title tag in index.html
# 2. Replace all occurrences of the word "Contributor" with "Junior" in main.js
# 3. Update the description in system.md
# 4. Test changes to ensure they don't break anything.

cat > src/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>
EOF

sed -i '' 's/Contributor/Junior/g' src/main.js

cat > prompt/system.md << 'EOF'
You're the 'Junior', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists. Do not edit files without knowing their current content, ask for their contents instead!
EOF
