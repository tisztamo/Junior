#!/bin/sh
set -e
goal="Implement frontend modifications"
echo "Plan:"
echo "1. Modify src/frontend/App.jsx based on requirements"
echo "2. Modify src/frontend/index.html to update the 'app' div"

# Modify src/frontend/App.jsx
cat > src/frontend/App.jsx << 'EOF'
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  const bindings = keyBindings();
  useKeyBindings(bindings);

  return (
    <div class="p-2 sm:p-4 xs:p-4">
      <div class="bg-main max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <PromptCreation />
        <ChangeExecution />
        <ChangeInspection />
        <ChangeFinalization />
      </div>
    </div>
  );
};

export default App;
EOF

# Modify src/frontend/index.html
cat > src/frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="icon" href="/assets/favicon.ico" type="image/x-icon">
  <title>Junior</title>
</head>
<body>
  <div id="app" class="bg-emphasize"></div>
  <script type="module" src="/index.jsx"></script>
</body>
</html>
EOF

echo "\033[32mDone: $goal\033[0m\n"
