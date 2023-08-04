#!/bin/sh
set -e
goal="Change emphasize colors to be visibly different"
echo "Plan:"
echo "1. Modify the --emphasize-color to be close but visibly different from --text-color."
echo "2. Modify the --background-emphasize-color to be close but visibly different from --background-color."

cat << 'EOF' > src/frontend/styles/colors.css
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
