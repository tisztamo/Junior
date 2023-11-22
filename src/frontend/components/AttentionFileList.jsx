import { createEffect } from 'solid-js';
import { fileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import { requirements } from '../model/requirements';
import { useAttention } from '../model/useAttention';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange as handleAttentionChangeService } from '../service/handleAttentionChange';
import extractQuery from '../service/helpers/extractQuery';

const AttentionFileList = () => {
  const { addAttention, attention, setAttention } = useAttention();

  createEffect(() => {
    fetchFileList();
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    setAttention(attentionFromDescriptor);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  const onAttentionChange = async (newAttention) => {
    await handleAttentionChangeService(newAttention, setAttention);
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} 
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;
