import { createEffect, createSignal } from 'solid-js';
import { executionResult } from '../model/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;
  const [copyText, setCopyText] = createSignal('copy');

  const copyToClipboard = async (e) => {
    e.preventDefault(); // Prevent page load on click
    try {
      await navigator.clipboard.writeText(executionResult());
      setCopyText('copied');
      setTimeout(() => setCopyText('copy'), 2000);
    } catch (err) {
      alert("Failed to copy text!");
      console.warn("Copy operation failed:", err);
    }
  };

  createEffect(() => {
    if (container && executionResult() !== undefined && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`relative bg-gray-900 text-white p-4 rounded ${executionResult() !== undefined && executionResult() !== '' ? 'block' : 'hidden'}`}>
      <a href="#" class="underline absolute top-0 right-0 m-4" onClick={copyToClipboard}>{copyText()}</a>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
