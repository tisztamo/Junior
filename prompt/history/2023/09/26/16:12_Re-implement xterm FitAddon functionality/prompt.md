You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/service/terminal/setupXTerm.js:
```
import { Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = new FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

The fit addon for xterm has problems when importing, so we need to reimplement its functionality in js.

Create service/terminal/fitAddOn.js and use it in the terminal
Here is the original ts implementation:

import { Terminal, ITerminalAddon } from 'xterm';
import { IRenderDimensions } from 'browser/renderer/shared/Types';

interface ITerminalDimensions {
  /**
   * The number of rows in the terminal.
   */
  rows: number;

  /**
   * The number of columns in the terminal.
   */
  cols: number;
}

const MINIMUM_COLS = 2;
const MINIMUM_ROWS = 1;

export class FitAddon implements ITerminalAddon {
  private _terminal: Terminal | undefined;

  public activate(terminal: Terminal): void {
    this._terminal = terminal;
  }

  public dispose(): void {}

  public fit(): void {
    const dims = this.proposeDimensions();
    if (!dims || !this._terminal || isNaN(dims.cols) || isNaN(dims.rows)) {
      return;
    }

    // TODO: Remove reliance on private API
    const core = (this._terminal as any)._core;

    // Force a full render
    if (this._terminal.rows !== dims.rows || this._terminal.cols !== dims.cols) {
      core._renderService.clear();
      this._terminal.resize(dims.cols, dims.rows);
    }
  }

  public proposeDimensions(): ITerminalDimensions | undefined {
    if (!this._terminal) {
      return undefined;
    }

    if (!this._terminal.element || !this._terminal.element.parentElement) {
      return undefined;
    }

    // TODO: Remove reliance on private API
    const core = (this._terminal as any)._core;
    const dims: IRenderDimensions = core._renderService.dimensions;

    if (dims.css.cell.width === 0 || dims.css.cell.height === 0) {
      return undefined;
    }

    const scrollbarWidth = this._terminal.options.scrollback === 0 ?
      0 : core.viewport.scrollBarWidth;

    const parentElementStyle = window.getComputedStyle(this._terminal.element.parentElement);
    const parentElementHeight = parseInt(parentElementStyle.getPropertyValue('height'));
    const parentElementWidth = Math.max(0, parseInt(parentElementStyle.getPropertyValue('width')));
    const elementStyle = window.getComputedStyle(this._terminal.element);
    const elementPadding = {
      top: parseInt(elementStyle.getPropertyValue('padding-top')),
      bottom: parseInt(elementStyle.getPropertyValue('padding-bottom')),
      right: parseInt(elementStyle.getPropertyValue('padding-right')),
      left: parseInt(elementStyle.getPropertyValue('padding-left'))
    };
    const elementPaddingVer = elementPadding.top + elementPadding.bottom;
    const elementPaddingHor = elementPadding.right + elementPadding.left;
    const availableHeight = parentElementHeight - elementPaddingVer;
    const availableWidth = parentElementWidth - elementPaddingHor - scrollbarWidth;
    const geometry = {
      cols: Math.max(MINIMUM_COLS, Math.floor(availableWidth / dims.css.cell.width)),
      rows: Math.max(MINIMUM_ROWS, Math.floor(availableHeight / dims.css.cell.height))
    };
    return geometry;
  }
}


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

