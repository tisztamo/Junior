#!/bin/sh
set -e
goal="Implement styling for file statuses"
echo "Plan:"
echo "1. Modify colors in the colors.css file."
echo "2. Update the getStyleForFileStatus.jsx function to handle 'Deleted' files."
cat > ./src/frontend/styles/colors.css << 'EOF'
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
  --border-color: #d1d5db;
  --color-blue: rgb(59, 130, 246);
  --color-orange: rgb(253, 186, 116);
  --color-red: rgb(239, 68, 68);
  --color-green: rgb(34, 197, 94);
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}
EOF

cat > ./src/frontend/components/getStyleForFileStatus.jsx << 'EOF'
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'var(--color-green)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'var(--color-orange)' };
  } else if (working_dir === 'D') {
    return { color: 'var(--color-red)' };
  }
  return {}; // Default no text color style
}
EOF

echo "\033[32mDone: $goal\033[0m\n"