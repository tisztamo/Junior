#!/bin/sh
set -e
goal="Implement MultiSelect components with models"
echo "Plan:"
echo "1. Create model for the SearchBar state."
echo "2. Implement the SearchBar component."
echo "3. Implement the ResultSet component."
echo "4. Implement the FilteredList component."
echo "5. Implement the MultiSelect component combining the three components."
echo "6. Update SampleComponent to integrate the new MultiSelect."

# 1. Create model for the SearchBar state.
cat > src/frontend/model/searchBarModel.js <<EOF
import { createSignal } from 'solid-js';

const [searchValue, setSearchValue] = createSignal('');

export { searchValue, setSearchValue };
EOF

# 2. Implement the SearchBar component.
cat > src/frontend/components/SearchBar.jsx <<EOF
import { searchValue, setSearchValue } from '../model/searchBarModel';

const SearchBar = () => {
  const handleInputChange = (e) => {
    setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={searchValue()}
      onInput={handleInputChange}
      class="border rounded p-2 w-full"
    />
  );
};

export default SearchBar;
EOF

# 3. Implement the ResultSet component.
cat > src/frontend/components/ResultSet.jsx <<EOF
const ResultSet = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
EOF

# 4. Implement the FilteredList component.
cat > src/frontend/components/FilteredList.jsx <<EOF
const FilteredList = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

# 5. Implement the MultiSelect component.
cat > src/frontend/components/MultiSelect.jsx <<EOF
import { searchValue } from '../model/searchBarModel';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  return (
    <div class="rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar />
      <FilteredList items={props.availableItems} filter={searchValue()} />
    </div>
  );
};

export default MultiSelect;
EOF

# 6. Update SampleComponent to integrate the new MultiSelect.
cat > src/frontend/components/SampleComponent.jsx <<EOF
import { createSignal, onCleanup } from 'solid-js';
import { sample, setSample } from '../model/sampleModel';
import sampleService from '../service/sampleService';
import MultiSelect from './MultiSelect';

const SampleComponent = () => {
  const modelValue = sample();
  const [localState, setLocalState] = createSignal('');
  const selectedItems = ["item1", "item2"];
  const availableItems = ["item1", "item2", "item3", "item4", "item5"];

  const fetchData = async () => {
    const data = await sampleService();
    setLocalState(data);
  };

  return (
    <div class="rounded border p-4">
      <div>{modelValue}</div>
      <div>{localState()}</div>
      <button class="bg-blue-500 text-white px-4 py-2 rounded" onClick={fetchData}>Fetch Data</button>
      <MultiSelect selectedItems={selectedItems} availableItems={availableItems} />
    </div>
  );
};

export default SampleComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"