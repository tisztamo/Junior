import * as vscode from 'vscode';
import { writeAttention } from './writeAttention';

export function activate(context: vscode.ExtensionContext) {
	console.log('Junior extension is now active!');

	let writeAttentionDisposable = vscode.commands.registerCommand('junior.writeAttention', writeAttention);

	context.subscriptions.push(writeAttentionDisposable);
}

export function deactivate() {}
