#!/bin/sh
set -e
<<<<<<< HEAD
goal="Add host warning to startVite"
echo "Plan:"
echo "1. Modify startVite.js to add the orange warning when hostArgPresent is true."

cat << 'EOF' > src/frontend/startVite.js
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import process from 'process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const hostArgPresent = process.argv.includes('--host');
=======
goal="Use useFillScreen to fill content vertically"
echo "Plan:"
echo "1. Create useFillScreen.js to encapsulate the logic of filling the screen vertically."
echo "2. Update App.jsx to use this new function and remove the added h-classes."

# Creating the useFillScreen.js function
cat << 'EOF' > src/frontend/service/useFillScreen.js
import { onCleanup } from 'solid-js';

export default function useFillScreen(containerRef) {
  const resizeContent = () => {
    if (containerRef()) {
      const vh = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0);
      containerRef().style.height = `${vh}px`;
    }
  };

  window.addEventListener('resize', resizeContent);
  resizeContent();  // call once to set the initial height

  onCleanup(() => {
    window.removeEventListener('resize', resizeContent);
  });
}
EOF

# Updating the App.jsx
cat << 'EOF' > src/frontend/App.jsx
import useKeyBindings from './service/useKeyBindings';
import useFillScreen from './service/useFillScreen';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  const bindings = keyBindings();
  useKeyBindings(bindings);
  let containerRef;
  useFillScreen(() => containerRef);

  return (
    <div ref={containerRef} class="flex flex-col min-h-screen">
      <div class="bg-main max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 px-2 sm:px-4 xs:px-4 pb-4">
        <NavBar />
        <PromptCreation />
        <ChangeExecution />
        <ChangeInspection />
        <ChangeFinalization />
      </div>
    </div>
  );
};
>>>>>>> da2f768abb8387013d6fe90270f69eb5367f5f23

  if (hostArgPresent) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      ...(hostArgPresent ? { host: true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"