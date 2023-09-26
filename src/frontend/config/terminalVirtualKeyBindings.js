const terminalVirtualKeyBindings = () => {
  return [
    { label: 'Esc', action: '\x1B' },
    { label: '-', action: '-' },
    { label: ':', action: ':' },
    { label: 'Ctrl-Z', action: '\x1A' },
    { label: 'Ctrl-Y', action: '\x19' },
    { label: 'Ctrl-X', action: '\x18' },
    { label: 'Ctrl-V', action: '\x16' },
    { label: 'F1', action: '\x1BOP' },
    { label: 'F5', action: '\x1B[15~' },
    { label: 'F6', action: '\x1B[17~' },
    { label: 'F7', action: '\x1B[18~' }
  ];
};

export default terminalVirtualKeyBindings;
