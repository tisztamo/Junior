#!/bin/sh
set -e
goal="Add emphasize-background-color, remove xl, 2xl screens"
echo "Plan:"
echo "1. Add --background-emphasize-color variable to colors.css with a color close to the normal background."
echo "2. Update backgroundColor in tailwind.config.cjs to use the new variable."
echo "3. Remove 'xl' and '2xl' screen sizes from tailwind.config.cjs."

# Step 1: Add --background-emphasize-color variable to colors.css with a color close to the normal background
cat > src/frontend/styles/colors.css << 'EOF'
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #e2e8f0;
  --background-emphasize-color: #e5e7eb;
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #2d3748;
  --background-emphasize-color: #2c2f33;
}
EOF

# Step 2: Update backgroundColor in tailwind.config.cjs to use the new variable
# Step 3: Remove 'xl' and '2xl' screen sizes from tailwind.config.cjs
cat > src/frontend/tailwind.config.cjs << 'EOF'
module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
    },
    extend: {
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        text: "var(--text-color)",
        emphasize: "var(--emphasize-color)",
      },
      backgroundColor: {
        main: "var(--background-color)",
        emphasize: "var(--background-emphasize-color)",
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
