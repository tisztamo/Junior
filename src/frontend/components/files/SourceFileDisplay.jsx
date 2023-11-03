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

    if (window.Prism) {
      const codeElement = document.querySelector('.source-display-code');
      const pre = codeElement.parentElement;

      const newCode = document.createElement('CODE');
      newCode.className = codeElement.className;
      newCode.textContent = data;

      window.Prism.highlightElement(newCode);
      pre.replaceChild(newCode, codeElement);
    }
  };

  onMount(() => {
    fetchData();
  });

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class={`language-${language}`} style={{ margin: 0 }}>
        <code class={`language-${language} source-display-code`}>{fileContent()}</code>
      </pre>
    </div>
  );
};

export default SourceFileDisplay;
