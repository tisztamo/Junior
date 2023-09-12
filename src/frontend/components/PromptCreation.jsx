import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';
import SourceFileDisplay from './files/SourceFileDisplay';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
      <SourceFileDisplay path="package.json" />
    </>
  );
};

export default PromptCreation;
