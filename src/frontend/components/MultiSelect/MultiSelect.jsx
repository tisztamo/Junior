import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const [selectedItems, setSelectedItems] = createSignal([...props.selectedItems]);

  createEffect(() => {
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount));
  });

  const addFirstFilteredItem = () => {  // Add the first item from the filtered list to selected items
    const updatedItems = [filteredList()[0], ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-4 rounded border border-border">
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} addFirstFilteredItem={addFirstFilteredItem} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
