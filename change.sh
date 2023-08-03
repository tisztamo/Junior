#!/bin/sh
set -e
goal="Fix theme switcher to reflect changes on screen"
echo "Plan:"
echo "1. Add dark theme styling in Tailwind configuration."
echo "2. Modify the ThemeSwitcher component to use the correct class."

# Step 1: Adding dark theme styling in Tailwind configuration
cat << 'EOF' > src/frontend/tailwind.config.cjs
module.exports = {
  darkMode: 'class', // Add this line
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
      // Extend the spacing for larger gaps
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      // Extend the button styles for larger buttons
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      // Extend the maxWidth for desktop container
      maxWidth: {
        'desktop': '640px',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

# Step 2: Modify the ThemeSwitcher component to use the correct class
cat << 'EOF' > src/frontend/components/ThemeSwitcher.jsx
import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    document.body.className = currentTheme === 'dark' ? 'dark' : ''; // Change this line
    localStorage.setItem('theme', currentTheme);
  });

  const toggleTheme = () => {
    setTheme(theme() === 'dark' ? 'light' : 'dark');
  };

  return (
    <button onClick={toggleTheme} class="text-xl underline cursor-pointer">
      {theme() === 'dark' ? 'Light Mode' : 'Dark Mode'}
    </button>
  );
};

export default ThemeSwitcher;
EOF

echo "\033[32mDone: $goal\033[0m\n"
