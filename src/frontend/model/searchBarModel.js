import { createSignal } from 'solid-js';

const [searchValue, setSearchValue] = createSignal('');

export { searchValue, setSearchValue };
