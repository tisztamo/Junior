import { createEffect } from 'solid-js';
import handleExecuteChange from '../service/execute/handleExecuteChange';
import { setChangeInput, changeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handleInput = async (e) => {
    setChangeInput(e.target.value);
    if (e.target.value.length > 50) {
      await handleExecuteChange();
      setChangeInput(''); // Clear input after execution
    }
  };

  return (
    <button className="w-full px-4 py-4 pb-3 bg-orange-300 text-lg text-bg font-semibold rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
      ) : (
        <textarea
          rows="1"
          className="w-full px-2 py-2 bg-orange-200 text-lg text-bg font-semibold resize-none"
          placeholder="Paste here to execute"
          value={changeInput()}
          onInput={handleInput}
        />
      )}
    </button>
  );
};

export default ExecuteButton;
