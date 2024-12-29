#!/bin/sh
set -e
goal="Refactor scoring logic and modularize"
echo "Plan:"
echo "1. Create getDecreasingScore.js"
echo "2. Update scoringConstants.js"
echo "3. Modify extractQuery.js"

# Create getDecreasingScore.js with new exponential scoring logic
cat > src/frontend/service/helpers/getDecreasingScore.js << 'EOF'
import { scoringConstants } from './scoringConstants';

export function getDecreasingScore(index) {
    const { START_SCORE, DECREMENT, MIN_SCORE } = scoringConstants;
    let score = START_SCORE * Math.pow(1 - DECREMENT, index);
    return score < MIN_SCORE ? MIN_SCORE : score;
}
EOF

# Update scoringConstants.js to remove getDecreasingScore function
cat > src/frontend/service/helpers/scoringConstants.js << 'EOF'
export const scoringConstants = {
    START_SCORE: 1.0,
    DECREMENT: 0.125,
    MIN_SCORE: 0.25
};
EOF

# Update extractQuery.js to import getDecreasingScore from its new location
cat > src/frontend/service/helpers/extractQuery.js << 'EOF'
import { getDecreasingScore } from './getDecreasingScore';

const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
    return requirements.split(/\W+/)
        .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
        .map((word, index) => ({ keyword: word.toLowerCase(), weight: getDecreasingScore(index) }));
}
EOF

echo "\033[32mDone: $goal\033[0m\n"