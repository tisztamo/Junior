#!/bin/sh
set -e
goal="Integrate CSS color variables into JSX inline styles"
echo "Plan:"
echo "1. Define color variables in colors.css based on docs/assets/styles.css."
echo "2. Modify getStyleForFileStatus.jsx to use these new color variables in inline styles."

# Define color variables in colors.css
cat > ./src/frontend/styles/colors.css << 'EOF'
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
  --border-color: #d1d5db;
  --color-blue: rgb(59, 130, 246);
  --color-orange: rgb(253, 186, 116);
  --color-red: rgb(185, 28, 28);
  --color-green: rgb(21, 128, 61);
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}
EOF

# Modify getStyleForFileStatus.jsx to use CSS variables in inline styles
cat > ./src/frontend/components/getStyleForFileStatus.jsx << 'EOF'
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'var(--color-green)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'var(--color-orange)' };
  }
  return {}; // Default no text color style
}
EOF

echo "\033[32mDone: $goal\033[0m\n"