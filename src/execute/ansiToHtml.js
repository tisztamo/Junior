const ANSI_COLORS = {
  '30': 'black',
  '31': 'red',
  '32': 'lightgreen',
  '33': 'yellow',
  '34': 'blue',
  '35': 'magenta',
  '36': 'cyan',
  '37': 'white',
};

const ansiToHtml = (terminalOutputStr) => {
  let result = '<span>' + terminalOutputStr.replace(/\033\[([0-9]+)m/g, (match, p1) => {
    const color = ANSI_COLORS[p1];
    return color ? `</span><span style="color:${color}">` : '</span><span>';
  });
  result += '</span>';
  return result.replace(/\n/g, '<br />');
};

export default ansiToHtml;
