import { createSignal, onMount } from 'solid-js';
import fileReadService from '../../service/files/fileReadService';

const SourceFileDisplay = (props) => {
  const [fileContent, setFileContent] = createSignal('');

  const getLanguageFromPath = (path) => {
    const extension = path.split('.').pop().toLowerCase();
    return extension;
  };

  const fetchData = async () => {
    const data = await fileReadService(props.path);
    setFileContent(data);
  };

  onMount(fetchData);

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border p-4">
      <pre><code class={`language-${language}`}>{fileContent()}</code></pre>
    </div>
  );
};

export default SourceFileDisplay;
