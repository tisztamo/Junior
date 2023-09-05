const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
  return requirements.split(/\W+/)
    .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
    .join(' ');
}
