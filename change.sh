#!/bin/sh
# Goal: Refactor TitleDisplay to NavBar, introduce subtitle and clickable link.
# Plan:
# 1. Rename TitleDisplay.jsx to NavBar.jsx.
# 2. Refactor NavBar component to use a constant for the title instead of the solid-js signal.
# 3. Add a new subtitle "Your AI contributor".
# 4. Make the subtitle clickable and link to https://github.com/tisztamo/Junior.
# 5. Update App.jsx to import NavBar instead of TitleDisplay.

mv src/frontend/components/TitleDisplay.jsx src/frontend/components/NavBar.jsx

cat <<'EOF' > src/frontend/components/NavBar.jsx
import { createSignal } from 'solid-js';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div>
      <h1 class="text-center text-3xl mt-6">{title}</h1>
      <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
    </div>
  );
};

export default NavBar;
EOF

sed -i '' 's/TitleDisplay/NavBar/g' src/frontend/App.jsx
