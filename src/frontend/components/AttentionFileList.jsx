import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} defaultQuery={defaultQuery} />
    </div>
  );
};

export default AttentionFileList;
