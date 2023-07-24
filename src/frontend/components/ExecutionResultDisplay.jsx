import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  return (
    <div class="w-64 px-4 py-4 bg-gray-300 text-black rounded">
      {executionResult()}
    </div>
  );
};

export default ExecutionResultDisplay;
