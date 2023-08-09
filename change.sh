#!/bin/sh
set -e
goal="Rewrite system prompt in system.md to be concise"
echo "Plan:"
echo "1. Rewrite the system prompt in system.md to be more concise."
echo "2. Verify that the new content is correct."

# Step 1: Rewrite the system prompt in system.md to be more concise
cat > prompt/system.md << 'EOF'
You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!
EOF

echo "\033[32mDone: $goal\033[0m\n"
