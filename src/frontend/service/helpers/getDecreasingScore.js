import { scoringConstants } from './scoringConstants';

export function getDecreasingScore(index) {
    const { START_SCORE, DECREMENT, MIN_SCORE } = scoringConstants;
    let score = START_SCORE * Math.pow(1 - DECREMENT, index);
    return score < MIN_SCORE ? MIN_SCORE : score;
}
