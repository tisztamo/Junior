const printNewText = (lastTextLength) => (partialResponse) => {
  const newText = partialResponse.text.slice(lastTextLength);
  process.stdout.write(newText);
  lastTextLength = partialResponse.text.length;
}

export { printNewText };
