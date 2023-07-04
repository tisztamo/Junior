import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';

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
    setPrompt(data.prompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={generatePrompt}>Start</button>
      <p>{prompt()}</p>
    </>
  );
};

render(App, document.getElementById('app'));
