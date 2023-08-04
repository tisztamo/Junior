#!/bin/sh
set -e
goal="Redesign the navbar layout with specified design"
echo "Plan:"
echo "1. Modify the NavBar.jsx to make it full width using w-full class."
echo "2. Rearrange the components within the NavBar.jsx to match the required design."

cat > src/frontend/components/NavBar.jsx << 'EOF'
import { createSignal } from 'solid-js';
import ThemeSwitcher from './ThemeSwitcher';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative w-full">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <div class="flex flex-col items-center justify-center">
        <h1 class="text-center text-3xl mt-6">{title}</h1>
        <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
      </div>
    </div>
  );
};

export default NavBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"
