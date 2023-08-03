#!/bin/sh
set -e
goal="Implement theme switcher in navbar"
echo "Plan:"
echo "1. Create ThemeSwitcher.jsx, implementing the theme switching functionality."
echo "2. Modify NavBar.jsx to include the theme switcher on the top right."

# Step 1: Create ThemeSwitcher.jsx
cat > src/frontend/components/ThemeSwitcher.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    document.body.className = currentTheme;
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

# Step 2: Modify NavBar.jsx
cat > src/frontend/components/NavBar.jsx << 'EOF'
import { createSignal } from 'solid-js';
import ThemeSwitcher from './ThemeSwitcher';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <h1 class="text-center text-3xl mt-6">{title}</h1>
      <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
    </div>
  );
};

export default NavBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"
