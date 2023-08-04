#!/bin/sh
set -e
goal="Refactor App.jsx by splitting into components"
echo "Plan:"
echo "1. Create PromptCreation.jsx for TaskList to PromptDisplay"
echo "2. Create ChangeExecution.jsx for ExecuteButton and ExecutionResultDisplay"
echo "3. Create ChangeInspection.jsx for GitStatusDisplay"
echo "4. Create ChangeFinalization.jsx for CommitMessageInput, CommitButton, and RollbackButton"
echo "5. Modify App.jsx to include the new components"

# 1. Create PromptCreation.jsx for TaskList to PromptDisplay
cat <<EOF > src/frontend/components/PromptCreation.jsx
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
EOF

# 2. Create ChangeExecution.jsx for ExecuteButton and ExecutionResultDisplay
cat <<EOF > src/frontend/components/ChangeExecution.jsx
import ExecuteButton from './ExecuteButton';
import ExecutionResultDisplay from './ExecutionResultDisplay';

const ChangeExecution = () => {
  return (
    <>
      <ExecuteButton />
      <ExecutionResultDisplay />
    </>
  );
};

export default ChangeExecution;
EOF

# 3. Create ChangeInspection.jsx for GitStatusDisplay
cat <<EOF > src/frontend/components/ChangeInspection.jsx
import GitStatusDisplay from './GitStatusDisplay';

const ChangeInspection = () => {
  return (
    <GitStatusDisplay />
  );
};

export default ChangeInspection;
EOF

# 4. Create ChangeFinalization.jsx for CommitMessageInput, CommitButton, and RollbackButton
cat <<EOF > src/frontend/components/ChangeFinalization.jsx
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <CommitButton />
      <RollbackButton />
    </>
  );
};

export default ChangeFinalization;
EOF

# 5. Modify App.jsx to include the new components
cat <<EOF > src/frontend/App.jsx
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  return (
    <div id="app" class="p-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <PromptCreation />
        <ChangeExecution />
        <ChangeInspection />
        <ChangeFinalization />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"
