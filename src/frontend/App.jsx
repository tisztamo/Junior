import { createSignal } from 'solid-js';
import { marked } from 'marked';
import copy from 'clipboard-copy';
import { generatePrompt } from './generatePrompt';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());
    
    // Copy original markdown to clipboard
    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    // Convert markdown to HTML for display
    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={handleGeneratePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

export default App;
