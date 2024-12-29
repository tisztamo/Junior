#!/bin/sh
set -e
goal="Refactor scoring constants in scoringConstants.js"
echo "Plan:"
echo "1. Update scoringConstants.js with new constant values."

cat > src/frontend/service/helpers/scoringConstants.js << 'EOF'
export const scoringConstants = {
    START_SCORE: 0.5,
    DECREMENT: 0.05,
    MIN_SCORE: 0.1
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
