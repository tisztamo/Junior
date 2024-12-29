#!/bin/sh
set -e
goal="Implement RepoInfo in NavBar"
echo "Plan:"
echo "1. Create RepoInfo.jsx component with the given specifications."
echo "2. Import and integrate the RepoInfo component into NavBar.jsx."

# Step 1: Create RepoInfo.jsx component

cat > src/frontend/components/RepoInfo.jsx << 'EOF'
import { createSignal } from 'solid-js';

const RepoInfo = () => {
  return (
    <span class="text-sm font-mono bg-gray-200 px-2 py-1 rounded">
      @aijunior/dev main
    </span>
  );
};

export default RepoInfo;
EOF

# Step 2: Import and integrate RepoInfo into NavBar.jsx

cat > src/frontend/components/NavBar.jsx << 'EOF'
import ThemeSwitcher from './ThemeSwitcher';
import SubTitle from './SubTitle';
import RepoInfo from './RepoInfo';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative w-full">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <div class="flex flex-col items-center justify-center">
        <a href="https://github.com/tisztamo/Junior" class="text-center text-3xl mt-6 no-underline">{title}</a>
        <SubTitle />
        <RepoInfo />
      </div>
    </div>
  );
};

export default NavBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"