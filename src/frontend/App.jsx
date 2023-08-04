import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import CommitButton from './components/CommitButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';
import CommitMessageInput from './components/CommitMessageInput';

const App = () => {
  return (
    <div id="app" class="m-2 bg-maindark:bg-dark-background bg-light-background dark:text-dark-text text-light-text">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ExecutionResultDisplay />
        <GitStatusDisplay />
        <CommitMessageInput />
        <CommitButton />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
