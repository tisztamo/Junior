const PromptsToTryHelp = () => {
  const showAlert = () => {
    alert('These are sample prompts for Junior. To customize this list, create a prompt/totry folder in your project directory and add files to be displayed.');
  };

  return (
    <span class="inline-block cursor-pointer text-blue-500" onClick={showAlert}>ℹ️</span>
  );
};

export default PromptsToTryHelp;
