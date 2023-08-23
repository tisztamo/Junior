import TasksList from './TasksList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
