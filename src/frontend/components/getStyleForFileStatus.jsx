export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'rgb(34, 197, 94)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'rgb(253, 186, 116)' };
  }
  return {}; // Default no text color style
}
