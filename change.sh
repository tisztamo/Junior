#!/bin/bash

# Ensure the frontend/components directory exists
mkdir -p ./src/frontend/components

# Create the NotesInput component
cat > ./src/frontend/components/NotesInput.jsx << EOL
import { createSignal } from 'solid-js';

const NotesInput = () => {
  const [notes, setNotes] = createSignal('');
  
  return (
    <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
  );
};

export default NotesInput;
EOL

# Create the StartButton component
cat > ./src/frontend/components/StartButton.jsx << EOL
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({notes, setPrompt}) => {
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
    <button onClick={handleGeneratePrompt}>Start</button>
  );
};

export default StartButton;
EOL

# Create the PromptDisplay component
cat > ./src/frontend/components/PromptDisplay.jsx << EOL
const PromptDisplay = ({prompt}) => {
  return (
    <div innerHTML={prompt()}></div>
  );
};

export default PromptDisplay;
EOL

# Create the TasksList component
cat > ./src/frontend/components/TasksList.jsx << EOL
import { fetchTasks } from '../fetchTasks';

const TasksList = () => {
  const tasks = fetchTasks();

  return (
    <div>
      <label>Tasks:</label>
      <select>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOL

# Update the App.jsx file to use the new components
cat > ./src/frontend/App.jsx << EOL
import { createSignal } from 'solid-js';
import PromptDescriptorViewer from './PromptDescriptorViewer';
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <PromptDescriptorViewer />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;
EOL

