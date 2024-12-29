#!/bin/sh
set -e
goal="Improve documentation colors"
echo "Plan:"
echo "1. Update 'docs/_coverpage.md' to apply the red and green colors."

# Update the 'docs/_coverpage.md' with the required changes
cat > docs/_coverpage.md << 'EOF'
# <span class="cover-color-blue">**You are the Pro,**</span> <span class="cover-color-orange">**Junior&nbsp;codes**</span>

Kraft code with the **Junior AI IDE**

<span class="cover-color-red">Works on large codebases,</span> <span class="cover-color-green">soon on your mobile phone.</span>

![](assets/logo.svg)
EOF

echo "\033[32mDone: $goal\033[0m\n"