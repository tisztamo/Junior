#!/bin/sh
set -e
goal="Add styles for h2, h3 and lists in markdown.css"
echo "Plan:"
echo "1. Add styles for h2 and h3 headings in the markdown.css file."
echo "2. Add styles for unordered (ul) and ordered (ol) lists in the markdown.css file."

# Begin commands
cat << 'EOF' > src/frontend/styles/markdown.css
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

.markdown {
  & h1 {
    @apply text-4xl font-bold mb-4;
  }

  & h2 {
    @apply text-3xl font-bold mb-3;
  }

  & h3 {
    @apply text-2xl font-semibold mb-2;
  }

  & p {
    @apply text-base font-normal mb-4;
  }

  & ul, & ol {
    @apply list-decimal list-inside mb-4;
  }

  & pre {
    @apply bg-gray-100 p-4 font-mono;
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
