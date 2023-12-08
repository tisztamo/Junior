const PromptsToTryHelp = () => {
  const showAlert = () => {
    alert('These are sample prompts you can use with Junior. Create a prompt/totry folder in your project directory and add files to have them displayed here.');
  };

  return (
    <span class="inline-block cursor-pointer text-blue-500" onClick={showAlert}>❓</span>
  );
};

export default PromptsToTryHelp;
