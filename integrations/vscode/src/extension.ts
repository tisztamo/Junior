import * as vscode from 'vscode';
import { writeAttention } from './writeAttention';

export function activate(context: vscode.ExtensionContext) {
	console.log('Junior extension is now active!');

	let helloWorldDisposable = vscode.commands.registerCommand('junior.helloWorld', () => {
		vscode.window.showInformationMessage('Hello World from Junior!');
	});

	let writeAttentionDisposable = vscode.commands.registerCommand('junior.writeAttention', writeAttention);

	context.subscriptions.push(helloWorldDisposable);
	context.subscriptions.push(writeAttentionDisposable);
}

export function deactivate() {}
