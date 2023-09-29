#!/bin/sh
set -e
goal="Add 'Scroll' text with non-colored arrows to coverpage"
echo "Plan:"
echo "1. Read the existing coverpage content into the shell script."
echo "2. Append the desired line with non-colored Unicode arrows and 'Scroll' text."
echo "3. Write the updated content back to the coverpage."

# Using heredoc to capture the existing content and append the new line
cat > ./docs/_coverpage.md << 'EOF'
# <span class="cover-color-blue">**You are the Pro,**</span> <span class="cover-color-orange">**Junior&nbsp;codes**</span>

Kraft code with the **Junior AI IDE**

<span class="cover-color-red">Works on large codebases,</span> <span class="cover-color-green">soon on your mobile phone.</span>

![](assets/logo.svg)

↑ Scroll ↑
EOF

echo "\033[32mDone: $goal\033[0m\n"