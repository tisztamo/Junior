import terminalConnection from './terminalConnection';

export function sendTerminalResizeNotification(rows, cols) {
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'resize', rows, cols }));
}
