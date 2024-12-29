#!/bin/sh
set -e
goal="Improve documentation coverpage"
echo "Plan:"
echo "1. Move SVG logo to bottom."
echo "2. Change 'scroll' to div positioned 30px below."

# Modify _coverpage.md file
cat > ./docs/_coverpage.md << 'EOF'
# <span class="cover-color-blue">**You are the Pro,**</span> <span class="cover-color-orange">**Junior&nbsp;codes**</span>

Kraft code with the **Junior AI IDE**

<span class="cover-color-red">Works on large codebases,</span> <span class="cover-color-green">soon on your mobile phone.</span>

<div style="position:relative; top:30px;">↑ Scroll ↑</div>

![](assets/logo.svg)
EOF

echo "\033[32mDone: $goal\033[0m\n"