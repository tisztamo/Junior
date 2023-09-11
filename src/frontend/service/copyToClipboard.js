const copyToClipboard = async (text) => {
  if (navigator.clipboard && navigator.clipboard.writeText) {
    await navigator.clipboard.writeText(text);
    console.log('Prompt copied to clipboard!');
  } else {
    // Use the alternative method: Using a temporary textarea.
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    console.log('Prompt copied to clipboard using alternative method!');
  }
};

export default copyToClipboard;
