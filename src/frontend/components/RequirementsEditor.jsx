import { createSignal } from 'solid-js';
import postDescriptor from '../service/postDescriptor';

const RequirementsEditor = () => {
  const [requirements, setRequirements] = createSignal('');

  const handleRequirementsChange = async (e) => {
    setRequirements(e.target.value);
    await postDescriptor({ requirements: e.target.value });
  };

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <label class="text-lg mr-2">Requirements:</label>
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        value={requirements()}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
