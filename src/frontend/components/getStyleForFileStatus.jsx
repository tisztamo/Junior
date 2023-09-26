export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'var(--color-green)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'var(--color-orange)' };
  } else if (working_dir === 'D') {
    return { color: 'var(--color-red)' };
  }
  return {}; // Default no text color style
}
