#!/bin/sh
set -e
goal="Re-implement xterm FitAddon functionality"
echo "Plan:"
echo "1. Create fitAddOn.js with FitAddon implementation and comment."
echo "2. Update setupXTerm.js to use the new FitAddon."
echo "3. Uninstall xterm-addon-fit npm package."

# 1. Create fitAddOn.js with FitAddon implementation and comment.
cat > ./src/frontend/service/terminal/fitAddOn.js << 'EOF'
// Re-implementation of xterm FitAddon due to issues with Vite handling CommonJS xterm plugins.
export function FitAddon() {
  let _terminal;

  function activate(terminal) {
    _terminal = terminal;
  }

  function fit() {
    const dims = proposeDimensions();
    if (!dims || !_terminal || isNaN(dims.cols) || isNaN(dims.rows)) {
      return;
    }

    const core = _terminal._core;
    if (_terminal.rows !== dims.rows || _terminal.cols !== dims.cols) {
      core._renderService.clear();
      _terminal.resize(dims.cols, dims.rows);
    }
  }

  function proposeDimensions() {
    if (!_terminal) {
      return undefined;
    }

    if (!_terminal.element || !_terminal.element.parentElement) {
      return undefined;
    }

    const core = _terminal._core;
    const dims = core._renderService.dimensions;

    if (dims.css.cell.width === 0 || dims.css.cell.height === 0) {
      return undefined;
    }

    const scrollbarWidth = _terminal.options.scrollback === 0 ? 0 : core.viewport.scrollBarWidth;
    const parentElementStyle = window.getComputedStyle(_terminal.element.parentElement);
    const parentElementHeight = parseInt(parentElementStyle.getPropertyValue('height'));
    const parentElementWidth = Math.max(0, parseInt(parentElementStyle.getPropertyValue('width')));
    const elementStyle = window.getComputedStyle(_terminal.element);
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
      cols: Math.max(2, Math.floor(availableWidth / dims.css.cell.width)),
      rows: Math.max(1, Math.floor(availableHeight / dims.css.cell.height))
    };
    return geometry;
  }

  return { activate, fit };
}
EOF

# 2. Update setupXTerm.js to use the new FitAddon.
cat > ./src/frontend/service/terminal/setupXTerm.js << 'EOF'
import { Terminal } from 'xterm';
import { FitAddon } from './fitAddOn';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
EOF

# 3. Uninstall xterm-addon-fit npm package.
npm uninstall xterm-addon-fit

echo "\033[32mDone: $goal\033[0m\n"