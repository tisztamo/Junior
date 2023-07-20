import { createSignal } from 'solid-js';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div>
      <h1 class="text-center text-3xl mt-6">{title}</h1>
      <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
    </div>
  );
};

export default NavBar;
