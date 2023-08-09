# Working set

src/frontend/components/RollbackButton.jsx:
```
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import ConfirmationDialog from './ConfirmationDialog';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  const handleConfirm = () => {
    setShowConfirmation(false);
    handleReset();
  };

  const handleRollbackClick = () => {
    setShowConfirmation(true);
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleRollbackClick}>Roll Back</button>
      <ConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;

```

src/frontend/components/ConfirmationDialog.jsx:
```
import { createEffect, createSignal } from "solid-js";

const ConfirmationDialog = (props) => {
  const [visible, setVisible] = createSignal(false);

  createEffect(() => {
    setVisible(props.visible);
  });

  return (
    <div className={visible() ? "block" : "hidden"}>
      <div className="fixed inset-0 flex items-center justify-center z-50">
        <div className="bg-white p-8 rounded shadow-lg">
          <p>Are you sure you want to roll back? This will reset the repo to the last commit and delete new files.</p>
          <button className="bg-red-700 text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Confirm</button>
          <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default ConfirmationDialog;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Make the confirmation question a bit more visible and separated from the rest of the text. - Fade the ui outside of the dialog while it is opened



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

