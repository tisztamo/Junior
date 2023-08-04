import TasksList from './TasksList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
