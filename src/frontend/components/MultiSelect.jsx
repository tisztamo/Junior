import { searchValue } from '../model/searchBarModel';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar />
      <FilteredList items={props.availableItems} filter={searchValue()} itemCount={props.itemCount} />
    </div>
  );
};

export default MultiSelect;
