import { PromptFile } from './types';

export const updateAttention = (currentAttention: string[] | undefined, newAttention: string[]): string[] => {
    // If there's no current attention section, just return the new attention.
    if (!currentAttention) {
        return newAttention;
    }

    // Filter out directories from the current attention.
    const currentDirectories = currentAttention.filter(item => item.endsWith('/'));

    // Add the current directories to the new attention list.
    return [...new Set([...currentDirectories, ...newAttention])];
};
