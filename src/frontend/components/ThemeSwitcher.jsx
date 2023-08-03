import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    document.body.className = currentTheme === 'dark' ? 'dark' : ''; // Change this line
    localStorage.setItem('theme', currentTheme);
  });

  const toggleTheme = () => {
    setTheme(theme() === 'dark' ? 'light' : 'dark');
  };

  return (
    <button onClick={toggleTheme} class="text-xl underline cursor-pointer">
      {theme() === 'dark' ? 'Light Mode' : 'Dark Mode'}
    </button>
  );
};

export default ThemeSwitcher;
