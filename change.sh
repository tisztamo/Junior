#!/bin/sh
set -e
goal="Add note about dogfooding in issue template"
echo "Plan:"
echo "1. Add a note about eating our own dog food to the issue template"

cat > .github/ISSUE_TEMPLATE/freely-interpreted-issue.md << 'EOF'
---
name: Freely interpreted issue
about: What it says
title: ''
labels: ''
assignees: ''

---

## Project Description

Hey, Contributor!

Interpret issues freely. Need help or have ideas? Comment right here. Remember, this is the only forum where Krisztián answers questions - your golden ticket to help!

**Note**: We eat our own dog food. We use Junior to work on Junior. So please, commit prompt.yaml, prompt.md, and change.sh as part of your contribution.

Keep it friendly, that's our vibe.

Happy contributing!
EOF

echo "\033[32mDone: $goal\033[0m\n"
