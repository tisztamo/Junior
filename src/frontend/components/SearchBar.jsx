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
