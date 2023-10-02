#!/bin/sh
set -e
goal="Remove bracketed paste control chars from terminal"
echo "Plan:"
echo "1. Update prependAndExtractLastLine.js to use a more encompassing regex for removing control characters"
cat > ./src/frontend/components/terminal/prependAndExtractLastLine.js << 'EOF'
export function prependAndExtractLastLine(lastLine, currentData) {
  const combinedData = `${lastLine}${currentData}`;
  const cleanedData = combinedData
    .replace(/\x1B(\[\?2004[h|l]|\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]?)/g, '');

  const lines = cleanedData.split(/\r(?!\n)|\n/);

  return getValidLastLine(lines);
}

function getValidLastLine(lines) {
  if (lines.length === 0) return '';

  const lastLine = lines[lines.length - 1].trim();
  if (lastLine === '' || lastLine.endsWith('$') || lastLine.endsWith('%')) {
    return getValidLastLine(lines.slice(0, -1));
  }
  
  return lastLine;
}
EOF
echo "\033[32mDone: $goal\033[0m\n"