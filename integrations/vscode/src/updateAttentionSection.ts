import { filterAttentionExcludes } from './filterAttentionExcludes';

export const updateAttentionSection = (currentWindows: string[], excludeList: string[], rootFolder: string) => {
    return filterAttentionExcludes(currentWindows, excludeList, rootFolder);
};
