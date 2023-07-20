#!/bin/sh
# Goal: Style markdown content with tailwind classes
# Plan:
# 1. Create markdown.css file
# 2. Add tailwind classes for h1, p and pre tags in markdown.css
# 3. Move styles.css to styles directory and update its import in index.jsx
# 4. Update PromptDisplay.jsx to use Solid's innerHTML directive

mkdir -p src/frontend/styles

cat << 'EOF' > src/frontend/styles/markdown.css
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

.markdown {
  & h1 {
    @apply text-4xl font-bold mb-4;
  }

  & p {
    @apply text-base font-normal mb-4;
  }

  & pre {
    @apply bg-gray-100 p-4 font-mono;
  }
}
EOF

mv src/frontend/styles.css src/frontend/styles/styles.css
echo "@import './markdown.css';" >> src/frontend/styles/styles.css

cat << 'EOF' > src/frontend/components/PromptDisplay.jsx
import { createSignal, onMount } from "solid-js";

const PromptDisplay = ({prompt}) => {
  let div;
  onMount(() => {
    div.innerHTML = prompt();
  });

  return (
    <div className="markdown" ref={div}></div>
  );
};

export default PromptDisplay;
EOF

# Updating import of styles.css in index.jsx
sed -i '' 's/import ".\/styles.css";/import ".\/styles\/styles.css";/g' src/frontend/index.jsx
