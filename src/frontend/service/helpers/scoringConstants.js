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
