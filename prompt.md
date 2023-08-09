# Working set

src/frontend/components/ConfirmationDialog.jsx:
```
import { createEffect, createSignal } from "solid-js";

const ConfirmationDialog = (props) => {
  const [visible, setVisible] = createSignal(false);
  const [disableConfirmation, setDisableConfirmation] = createSignal(false);

  const handleCheckboxChange = (event) => {
    setDisableConfirmation(event.target.checked);
    localStorage.setItem('Junior.disableRollbackConfirmation', event.target.checked);
  };

  createEffect(() => {
    setVisible(props.visible);
  });

  return (
    <div className={visible() ? "block" : "hidden"}>
      <div className="fixed inset-0 flex items-center justify-center z-50" style={{ backgroundColor: "var(--background-color)" }}>
        <div className="bg-main p-8 rounded shadow-lg text-text">
          <h3 className="text-xl mb-4">Are you sure you want to roll back?</h3>
          <p>This will reset the repo to the last commit and delete new files.</p>
          <label>
            <input type="checkbox" checked={disableConfirmation()} onChange={handleCheckboxChange} />
            Never show this again
          </label>
          <div>
            <button className="bg-emphasize text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Confirm</button>
            <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
          </div>
        </div>
      </div>
      <div className={visible() ? "fixed inset-0 bg-black opacity-50" : "hidden"}></div>
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

Add space above and below the checkbox, and also between the checkbox and its label.



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

