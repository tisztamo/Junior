const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Suggestions below. Search here!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={props.onKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-main text-emphasize my-2"
    />
  );
};

export default SearchBar;
