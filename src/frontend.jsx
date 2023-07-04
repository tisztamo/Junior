import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';
import copy from 'clipboard-copy';
import { marked } from 'marked';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const generatePrompt = async () => {
    const response = await fetch('http://localhost:3000/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ notes: notes() })
    });

    const data = await response.json();

    // Copy original markdown to clipboard
    copy(data.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    // Convert markdown to HTML for display
    const htmlPrompt = marked(data.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={generatePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

render(App, document.getElementById('app'));
