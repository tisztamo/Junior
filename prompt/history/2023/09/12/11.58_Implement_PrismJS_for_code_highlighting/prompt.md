You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/index.html:
```
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

```

./src/frontend/components/files/SourceFileDisplay.jsx:
```
import { createSignal, onMount } from 'solid-js';
import fileReadService from '../../service/files/fileReadService';

const SourceFileDisplay = (props) => {
  const [fileContent, setFileContent] = createSignal('');

  const fetchData = async () => {
    const data = await fileReadService(props.path);
    setFileContent(data);
  };

  onMount(fetchData);

  return (
    <div class="rounded border p-4">
      <code>{fileContent()}</code>
    </div>
  );
};

export default SourceFileDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Use Prism to highlight code blocks.

Use unpkg

Set the language from the file extension (use it directly)

Relevant docs snippet:

Usage with CDNs
In combination with CDNs, we recommend using the Autoloader plugin which automatically loads languages when necessary.

The setup of the Autoloader, will look like the following. You can also add your own themes of course.

<!DOCTYPE html>
<html>
<head>
	...
	<link href="https://{{cdn}}/prismjs@v1.x/themes/prism.css" rel="stylesheet" />
</head>
<body>
	...
	<script src="https://{{cdn}}/prismjs@v1.x/components/prism-core.min.js"></script>
	<script src="https://{{cdn}}/prismjs@v1.x/plugins/autoloader/prism-autoloader.min.js"></script>
</body>
</html>
Please note that links in the above code sample serve as placeholders. You have to replace them with valid links to the CDN of your choice.

CDNs which provide PrismJS are e.g. cdnjs, jsDelivr, and UNPKG.


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END


