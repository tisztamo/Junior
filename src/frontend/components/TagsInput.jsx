import { createSignal } from 'solid-js';
import { tags, setTags } from '../model/tagsModel';

const TagsInput = () => {
  const handleChange = (e) => {
    setTags(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Tags..." value={tags()} onInput={handleChange} />
  );
};

export default TagsInput;
