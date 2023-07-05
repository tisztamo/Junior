You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── current_prompt.md
├── current_prompt.yaml
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── run.sh
├── secret.sh
├── src/...
├── tmp/...

```
```
src/
├── attention/...
├── config.js
├── execute/...
├── frontend/...
├── frontend.jsx
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── server.js
├── utils/...
├── vite.config.js

```
src/frontend.jsx:
```
import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';
import copy from 'clipboard-copy';
import { marked } from 'marked';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const generatePrompt = async () => {
    const response = await fetch('http://localhost:3000/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ notes: notes() })
    });

    const data = await response.json();

    // Copy original markdown to clipboard
    copy(data.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    // Convert markdown to HTML for display
    const htmlPrompt = marked(data.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={generatePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

render(App, document.getElementById('app'));

```

src/index.html:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contributor</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>

```


# Task

## Refactor by split

A file is too big. We need to split it into parts.
Identify the possible parts and refactor the code in separate files!

Create a new folder &#34;src/frontend&#34;, and move the frontend.jsx to it. Also split the file logically.



# Output Format

Provide the new or modified file(s) as code blocks, each prefixed with its path and a colon.
JS files should only export a single function and be named after the function: e.g. `myFn.js` should export `myFn()`.
Always output full files, copying unchanged content.

E.g.:

texts/sample.txt:
```
A sample text file.
```


