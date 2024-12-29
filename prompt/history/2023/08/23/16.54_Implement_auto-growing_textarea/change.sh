#!/bin/sh
set -e
goal="Implement auto-growing textarea"
echo "Plan:"
echo "1. Modify the CSS of the textarea to make it a single-row by default."
echo "2. Implement auto-growing functionality for the textarea."
echo "3. Adjust the JSX for the RequirementsEditor component accordingly."
echo "4. Fix any arising issues with component references."

# Create new file to handle the auto-growing functionality
cat > src/frontend/components/AutoGrowingTextarea.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;

  const resize = () => {
    textRef.style.height = 'auto';
    textRef.style.height = textRef.scrollHeight + 'px';
  }

  // Use the onMount lifecycle hook to ensure the ref is available
  onMount(() => {
    textRef.addEventListener('input', resize, false);
    resize();  // To resize on initialization
  });

  // When the component unmounts, cleanup the event listener
  onCleanup(() => {
    textRef.removeEventListener('input', resize, false);
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      rows="1" // Start with one row
      style="overflow:hidden" // Hide the scrollbar
    />
  );
};

export default AutoGrowingTextarea;
EOF

# Modify the RequirementsEditor.jsx file to use the new AutoGrowingTextarea component
cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    await postDescriptor({ requirements: e.target.value });
  };

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-1 rounded border border-border mt-2">
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder="Enter your requirements..."
        value={requirements()}
        onInput={e => handleInput(e)}
        onChange={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"