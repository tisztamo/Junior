import { createSignal } from 'solid-js';
import ThemeSwitcher from './ThemeSwitcher';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative w-full">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <div class="flex flex-col items-center justify-center">
        <a href="https://github.com/tisztamo/Junior" class="text-center text-3xl mt-6 no-underline">{title}</a>
        <a href="https://github.com/tisztamo/Junior" class="text-center text-xl no-underline cursor-pointer">Your AI contributor</a>
      </div>
    </div>
  );
};

export default NavBar;
