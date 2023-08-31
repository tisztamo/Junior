import { createSignal, onCleanup } from 'solid-js';
import { sampleModel } from '../model/sampleModel';
import { sampleService } from '../service/sampleService';

const SampleComponent = () => {
  const modelValue = sampleModel();
  const [localState, setLocalState] = createSignal('');

  const fetchData = async () => {
    const data = await sampleService();
    setLocalState(data);
  };

  onCleanup(() => {});

  return (
    <div class="rounded border p-4">
      <div>{modelValue}</div>
      <div>{localState()}</div>
      <button class="bg-blue-500 text-white px-4 py-2 rounded" onClick={fetchData}>Fetch Data</button>
    </div>
  );
};

export default SampleComponent;
