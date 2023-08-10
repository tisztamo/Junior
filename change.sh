#!/bin/sh
set -e
goal="Modify button and tailwind config"
echo "Plan:"
echo "1. Modify tailwind.config.cjs to add new foreground color."
echo "2. Update GenerateButton.jsx component's tailwind classes."

cat <<EOF > src/frontend/tailwind.config.cjs
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
        'lg': '1.125rem',
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
        bg: "var(--background-color)",
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

cat <<EOF > src/frontend/components/GenerateButton.jsx
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-full px-4 py-4 bg-blue-500 text-bg text-lg rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt [G]</button>
  );
};

export default GenerateButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"