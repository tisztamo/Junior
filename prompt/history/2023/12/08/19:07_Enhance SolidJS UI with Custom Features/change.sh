#!/bin/sh
set -e
goal="Enhance SolidJS UI with Custom Features"
echo "Plan:"
echo "1. Update PromptsToTryHelp Component with new emoji and help message."
echo "2. Review and refactor JS files for ES6 compliance and single function export."
echo "3. Validate changes in SolidJS and Tailwind environment."

# Update PromptsToTryHelp.jsx
cat > src/frontend/components/promptCreation/PromptsToTryHelp.jsx << EOF
const PromptsToTryHelp = () => {
  const showAlert = () => {
    alert('These are sample prompts for Junior. To customize this list, create a prompt/totry folder in your project directory and add files to be displayed.');
  };

  return (
    <span class="inline-block cursor-pointer text-blue-500" onClick={showAlert}>ℹ️</span>
  );
};

export default PromptsToTryHelp;
EOF
echo "\033[32mDone: $goal\033[0m\n"