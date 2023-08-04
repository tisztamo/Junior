#!/bin/sh
set -e
goal="Implement emphasize colors for code blocks"
echo "Plan:"
echo "1. Update the markdown.css file to include the --emphasize-color and --background-emphasize-color for code blocks."

cat > src/frontend/styles/markdown.css << 'EOF'
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
    background-color: var(--background-emphasize-color);
    color: var(--emphasize-color);
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
