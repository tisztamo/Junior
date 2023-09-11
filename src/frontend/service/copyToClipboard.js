const copyToClipboardFallback = (text) => {
  const textarea = document.createElement('textarea');
  textarea.value = text;
  document.body.appendChild(textarea);
  textarea.select();
  try {
    document.execCommand('copy');
    return true;
  } catch (err) {
    return false;
  } finally {
    document.body.removeChild(textarea);
  }
};

const copyToClipboard = async (text) => {
  if (navigator.clipboard && navigator.clipboard.writeText) {
    await navigator.clipboard.writeText(text);
  } else {
    const success = copyToClipboardFallback(text);
    if (!success) {
      throw new Error('Failed to copy text');
    }
  }
};

export default copyToClipboard;
