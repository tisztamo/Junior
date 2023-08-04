#!/bin/sh
set -e
goal="Implement new styles and color configuration"
echo "Plan:"
echo "1. Create a new file styles/colors.css to define the CSS variables for text, background, and emphasize colors."
echo "2. Modify src/frontend/styles/styles.css to import the new styles/colors.css."
echo "3. Update src/frontend/tailwind.config.cjs to use the defined CSS variables for colors, remove unnecessary configurations, and introduce backgroundColor usage."

# Step 1: Create a new file styles/colors.css
cat << 'EOF' > src/frontend/styles/colors.css
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #e2e8f0;
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #2d3748;
}
EOF
echo "Created styles/colors.css."

# Step 2: Modify src/frontend/styles/styles.css to import the new styles/colors.css
cat << 'EOF' > src/frontend/styles/styles.css
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';
@import './colors.css';
@import './markdown.css';
EOF
echo "Modified src/frontend/styles/styles.css."

# Step 3: Update src/frontend/tailwind.config.cjs
cat << 'EOF' > src/frontend/tailwind.config.cjs
module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
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
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF
echo "Updated src/frontend/tailwind.config.cjs."

echo "\033[32mDone: $goal\033[0m\n"
