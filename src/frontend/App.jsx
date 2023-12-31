import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  const bindings = keyBindings();
  const unregister = useKeyBindings(bindings);

  onCleanup(unregister); 

  return (
    <div class="bg-main min-h-screen max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 px-2 sm:px-4 xs:px-4 pb-8">
      <NavBar />
      <PromptCreation />
      <ChangeExecution />
      <ChangeInspection />
      <ChangeFinalization />
    </div>
  );
};

export default App;
