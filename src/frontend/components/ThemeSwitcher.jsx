import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    const themeClass = currentTheme === 'dark' ? 'dark' : 'light';
    document.body.className = [themeClass, 'bg-main', 'text-text'].join(' '); // Adding classes 'bg-main' and 'text-text' to the body
    localStorage.setItem('theme', currentTheme);
  });

  const toggleTheme = () => {
    setTheme(theme() === 'dark' ? 'light' : 'dark');
  };

  return (
    <button onClick={toggleTheme} class="text-xl cursor-pointer">
      {theme() === 'dark' ? '🌙' : '☀️'} {/* Unicode symbols for dark and light modes */}
    </button>
  );
};

export default ThemeSwitcher;
