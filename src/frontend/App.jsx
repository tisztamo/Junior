import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    // Added margins between the components
    <div class="lg:m-8 m-4 flex flex-col items-center space-y-8">
      <TasksList />
      <PromptDescriptor />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay />
    </div>
  );
};

export default App;
