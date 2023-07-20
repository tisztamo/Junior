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
    // Applied maxWidth for desktop view and mx-auto to center the content
    // Applied padding on small screens to use the whole screen
    <div class="lg:m-8 m-4 flex flex-col items-center space-y-8 sm:p-0 lg:max-w-desktop mx-auto">
      <TasksList />
      <PromptDescriptor />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay />
    </div>
  );
};

export default App;
