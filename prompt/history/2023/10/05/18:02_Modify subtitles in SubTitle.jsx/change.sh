#!/bin/sh
set -e
goal="Modify subtitles in SubTitle.jsx"
echo "Plan:"
echo "1. Modify SubTitle.jsx to add and remove specified subtitles"

# Modifying SubTitle.jsx
cat > ./src/frontend/components/SubTitle.jsx << 'EOF'
import { createSignal } from "solid-js";

const SubTitle = () => {
  const subtitles = [
    "Your AI contributor",
    "Handkraft code with AI",
    "Crafting the future of code",
    "AI-driven development",
    "Metaprogramming in English",
  ];
  
  // Using createSignal to manage the state of the randomSubtitle
  const [randomSubtitle] = createSignal(subtitles[Math.floor(Math.random() * subtitles.length)]);
  
  return (
    <a href="https://github.com/tisztamo/Junior" class="text-center text-xl no-underline cursor-pointer">{randomSubtitle()}</a>
  );
};

export default SubTitle;
EOF

echo "\033[32mDone: $goal\033[0m\n"