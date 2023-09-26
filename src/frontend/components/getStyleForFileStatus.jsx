export default function getStyleForFileStatus(index, path) {
  if (index === 'M') {
    return { backgroundColor: 'rgb(34, 197, 94)' };
  } else if (index === 'A' && !path.includes('prompt/history')) {
    return { backgroundColor: 'rgb(253, 186, 116)' };
  }
  return {}; // Default no background style
}
