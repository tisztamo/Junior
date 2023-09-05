import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} />
    </div>
  );
};

export default AttentionFileList;
