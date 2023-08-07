#!/bin/sh
set -e
goal="Make title a link and remove underlines"
echo "Plan:"
echo "1. Update NavBar.jsx to make the title a link without underline"
echo "2. Ensure that the title link and the existing link do not have underlines"

# Step 1
cat << 'EOF' > src/frontend/components/NavBar.jsx
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
        <a href="https://github.com/tisztamo/Junior" class="text-center text-3xl mt-6 no-underline">{title}</a>
        <a href="https://github.com/tisztamo/Junior" class="text-center text-xl no-underline cursor-pointer">Your AI contributor</a>
      </div>
    </div>
  );
};

export default NavBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"
