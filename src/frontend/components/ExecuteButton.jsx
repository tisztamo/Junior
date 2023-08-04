import { createEffect, createSignal } from 'solid-js';
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';

const ExecuteButton = () => {
  const [inputAvailable, setInputAvailable] = createSignal(true);
  const [changeInput, setChangeInput] = createSignal('');

  const handleExecuteChange = async () => {
    const change = inputAvailable() ? await navigator.clipboard.readText() : changeInput();
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
  };

  // Check if clipboard reading is available
  createEffect(() => {
    if (!navigator.clipboard || !navigator.clipboard.readText) {
      setInputAvailable(false);
    }
  });

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {inputAvailable() ? (
        'Paste & Execute Change'
      ) : (
        <textarea
          rows="1"
          class="w-full px-2 py-2 bg-white text-black resize-none"
          placeholder="Paste here to execute"
          value={changeInput()}
          onPaste={handlePaste}
        />
      )}
    </button>
  );
};

export default ExecuteButton;
