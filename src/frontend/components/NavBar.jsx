import { createSignal } from 'solid-js';
import ThemeSwitcher from './ThemeSwitcher';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <h1 class="text-center text-3xl mt-6">{title}</h1>
      <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
    </div>
  );
};

export default NavBar;
