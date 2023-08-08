#!/bin/sh
set -e
goal="Rename Home to Junior Docs in sidebar"
echo "Plan:"
echo "1. Rename the 'Home' link to 'Junior Docs' in docs/_sidebar.md file."
cat > docs/_sidebar.md << 'EOF'
* [Junior Docs](./README.md)
* [Roadmap](./roadmap.md)
* [Web](./web.md)
* [Usage](./usage.md)
* [Prompt Descriptor](./descriptor.md)
EOF
echo "\033[32mDone: $goal\033[0m\n"
