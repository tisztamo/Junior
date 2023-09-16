export default function getBackgroundColorForFile(index, path) {
  if (index === 'M') { // Modified files
    return 'rgb(34 197 94)';
  } else if (index === 'A' && !path.includes('prompt/history')) { // New files excluding ones with 'prompt/history' in path
    return 'rgb(253 186 116)';
  }
  return ''; // Default no background color
}
