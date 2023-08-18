#!/bin/sh
set -e
goal="Refactor NavBar and randomize subtitle"
echo "Plan:"
echo "1. Remove unused createSignal from NavBar.jsx."
echo "2. Extract subtitle to its own component, SubTitle.jsx."
echo "3. Implement random subtitle selection in SubTitle.jsx."
echo "4. Replace the subtitle in NavBar.jsx with the new SubTitle component."

# Step 1: Remove unused createSignal from NavBar.jsx
cat << 'EOF' > src/frontend/components/NavBar.jsx
import ThemeSwitcher from './ThemeSwitcher';
import SubTitle from './SubTitle';

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
      </div>
    </div>
  );
};

export default NavBar;
EOF

# Step 2: Extract subtitle to its own component, SubTitle.jsx
cat << 'EOF' > src/frontend/components/SubTitle.jsx
const SubTitle = () => {
  const subtitles = [
    "Your AI contributor",
    "Handkraft code with AI",
    "Crafting the future of code",
    "Revolutionizing development",
    "AI-driven development",
  ];
  
  const randomSubtitle = subtitles[Math.floor(Math.random() * subtitles.length)];
  
  return (
    <a href="https://github.com/tisztamo/Junior" class="text-center text-xl no-underline cursor-pointer">{randomSubtitle}</a>
  );
};

export default SubTitle;
EOF

echo "\033[32mDone: $goal\033[0m\n"