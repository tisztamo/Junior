import { createSignal } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal(''); // Moved the searchBarModel logic to this component

  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} />
      <FilteredList 
        items={props.availableItems} 
        filter={searchValue()} 
        compare={props.compare} 
        itemCount={props.itemCount} 
      />
    </div>
  );
};

export default MultiSelect;
