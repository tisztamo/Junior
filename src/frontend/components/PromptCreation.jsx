import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';
import PromptsToTry from "./promptCreation/PromptsToTry";

const PromptCreation = () => {
  return (
    <>
      <PromptsToTry />
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
