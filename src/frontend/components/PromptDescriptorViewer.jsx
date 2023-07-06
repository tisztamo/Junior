import { createSignal, onMount } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    setDescriptorContent(text);
  });

  return (
    <pre>{descriptorContent()}</pre>
  );
};

export default PromptDescriptorViewer;
