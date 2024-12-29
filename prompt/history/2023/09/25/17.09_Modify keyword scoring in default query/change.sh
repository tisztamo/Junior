#!/bin/sh
set -e
goal="Modify keyword scoring in default query"
echo "Plan:"
echo "1. Create a new constants and utility function file for scoring"
echo "2. Modify extractQuery.js to incorporate new weighting mechanism"
echo "3. Update relevant imports"

# Step 1: Create a new file with constants and utility function
cat > ./src/frontend/service/helpers/scoringConstants.js << 'EOF'
export const scoringConstants = {
    START_SCORE: 1.0,
    DECREMENT: 0.125,
    MIN_SCORE: 0.25
};

export function getDecreasingScore(index) {
    const { START_SCORE, DECREMENT, MIN_SCORE } = scoringConstants;
    let score = START_SCORE - (index * DECREMENT);
    return score < MIN_SCORE ? MIN_SCORE : score;
}
EOF

# Step 2: Modify extractQuery.js to use the new weighting mechanism
cat > ./src/frontend/service/helpers/extractQuery.js << 'EOF'
import { getDecreasingScore } from './scoringConstants';

const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
    return requirements.split(/\W+/)
        .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
        .map((word, index) => ({ keyword: word.toLowerCase(), weight: getDecreasingScore(index) }));
}
EOF

# No imports need to be updated as we only introduced a new import, and no previously existing ones were changed.

echo "\033[32mDone: $goal\033[0m\n"