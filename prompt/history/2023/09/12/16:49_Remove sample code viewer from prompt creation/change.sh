#!/bin/sh
set -e
goal="Remove sample code viewer from prompt creation"
echo "Plan:"
echo "1. Remove the SourceFileDisplay component import from PromptCreation.jsx."
echo "2. Remove the SourceFileDisplay usage in the PromptCreation component."

cat > ./src/frontend/components/PromptCreation.jsx << 'EOF'
import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
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

EOF

echo "\033[32mDone: $goal\033[0m\n"