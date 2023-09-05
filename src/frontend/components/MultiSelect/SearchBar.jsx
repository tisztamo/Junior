const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={props.onKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-emphasize text-emphasize my-2"
    />
  );
};

export default SearchBar;
