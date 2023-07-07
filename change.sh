#!/bin/bash

# Modify extractCode.js to handle bash code blocks
cat > tmp/extractCode.tmp.js << 'EOF'
function extractCode(res) {
  const match = res.match(/```(sh|bash)([\s\S]*?)```/);
  return match ? match[2].trim() : null;
}

export { extractCode };
EOF

# Replace original extractCode.js with modified version
mv tmp/extractCode.tmp.js src/execute/extractCode.js

echo "Changes applied successfully"
