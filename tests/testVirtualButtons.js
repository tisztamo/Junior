import readline from 'readline';

const virtualButtons = {
  'Esc': '\x1B',
  '-': '-',
  ':': ':',
  'Ctrl-Z': '\x1A',
  'Ctrl-Y': '\x19',
  'Ctrl-X': '\x18',
  'Ctrl-V': '\x16',
  'F1': '\x1BOP',
  'F5': '\x1B[15~',
  'F6': '\x1B[17~',
  'F7': '\x1B[18~'
};

const pressedButtons = new Set();

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: true
});

const printInstructions = () => {
  console.log("\u001b[34mPlease press the following virtual buttons:\u001b[0m");
  for (const button in virtualButtons) {
    if (!pressedButtons.has(button)) {
      console.log(button);
    }
  }
};

const checkAndExit = () => {
  if (pressedButtons.size === Object.keys(virtualButtons).length) {
    console.log("\u001b[32mAll buttons were pressed. Exiting.\u001b[0m");
    rl.close();
    process.exit(0);
  } else {
    printInstructions();
  }
};

rl.on('line', (input) => {
  for (const button in virtualButtons) {
    if (input === virtualButtons[button] && !pressedButtons.has(button)) {
      console.log(`\u001b[32mButton ${button} was pressed.\u001b[0m`);
      pressedButtons.add(button);
    }
  }
  checkAndExit();
});

printInstructions();

