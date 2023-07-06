import { createSignal } from 'solid-js';
import { marked } from 'marked';
import copy from 'clipboard-copy';
import { generatePrompt } from './generatePrompt';
import { fetchTasks } from './fetchTasks';
import PromptDescriptorViewer from './PromptDescriptorViewer';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');
  const tasks = fetchTasks();

  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());

    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <PromptDescriptorViewer />
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={handleGeneratePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
      <div>
        <label>Tasks:</label>
        <select>
          {tasks().map(task => <option value={task}>{task}</option>)}
        </select>
      </div>
    </>
  );
};

export default App;
