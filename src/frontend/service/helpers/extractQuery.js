import { getDecreasingScore } from './scoringConstants';

const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
    return requirements.split(/\W+/)
        .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
        .map((word, index) => ({ keyword: word.toLowerCase(), weight: getDecreasingScore(index) }));
}
