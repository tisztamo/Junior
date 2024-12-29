#!/bin/sh
set -e
goal="Improve documentation"
echo "Plan:"
echo "1. Update the _coverpage.md for the specified improvements"
echo "2. No further steps required as all changes are contained in _coverpage.md"

cat << 'EOF' > docs/_coverpage.md
# <span class="cover-color-blue">**You are the Pro,**</span> <span class="cover-color-orange">**Junior&nbsp;codes**</span>

Kraft code with the **Junior AI IDE**

Works on large codebases, soon on your mobile phone.

![](assets/logo.svg)
EOF

echo "\033[32mDone: $goal\033[0m\n"