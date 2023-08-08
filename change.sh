#!/bin/sh
set -e
goal="Reorder documentation sidebar"
echo "Plan:"
echo "1. Update the _sidebar.md file with the new ordering of documentation links."

cat > docs/_sidebar.md << 'EOF'
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)
EOF

echo "\033[32mDone: $goal\033[0m\n"
