You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

integrations/vscode/package.json:
```
{
  "name": "junior",
  "displayName": "Junior",
  "description": "Your AI contributor",
  "version": "0.0.2",
  "engines": {
    "vscode": "^1.80.0"
  },
  "categories": [
    "Other"
  ],
  "activationEvents": [],
  "main": "./out/extension.js",
  "contributes": {
    "commands": [
      {
        "command": "junior.writeAttention",
        "title": "Junior: Write Attention"
      }
    ],
    "configuration": {
      "type": "object",
      "title": "Junior",
      "properties": {
        "junior.attentionExcludeList": {
          "type": "array",
          "default": [],
          "description": "List of file patterns to exclude from attention"
        }
      }
    }
  },
  "scripts": {
    "vscode:prepublish": "npm run compile",
    "compile": "tsc -p ./",
    "watch": "tsc -watch -p ./",
    "pretest": "npm run compile && npm run lint",
    "lint": "eslint src --ext ts",
    "test": "node ./out/test/runTest.js"
  },
  "devDependencies": {
    "@types/mocha": "^10.0.1",
    "@types/node": "20.2.5",
    "@types/vscode": "^1.80.0",
    "@typescript-eslint/eslint-plugin": "^5.59.8",
    "@typescript-eslint/parser": "^5.59.8",
    "@vscode/test-electron": "^2.3.2",
    "eslint": "^8.41.0",
    "mocha": "^10.2.0",
    "typescript": "^5.1.3"
  },
  "dependencies": {
    "js-yaml": "^4.1.0",
    "glob": "^8.1.0",
    "@types/glob": "^8.1.0"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "publisher": "JuniorOpenSourceProject"
}

```

integrations/vscode/tsconfig.json:
```
{
	"compilerOptions": {
		"module": "commonjs",
		"target": "ES2020",
		"outDir": "out",
		"lib": [
			"ES2020"
		],
		"sourceMap": true,
		"rootDir": "src",
		"strict": true   /* enable all strict type-checking options */
		/* Additional Checks */
		// "noImplicitReturns": true, /* Report error when not all code paths in function return a value. */
		// "noFallthroughCasesInSwitch": true, /* Report errors for fallthrough cases in switch statement. */
		// "noUnusedParameters": true,  /* Report errors on unused parameters. */
	}
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

ko@MacBook-Pro-5 vscode % vsce ls Executing prepublish script 'npm run vscode:prepublish'...
> junior@0.0.2 vscode:prepublish > npm run compile

> junior@0.0.2 compile > tsc -p ./
tsconfig.json(4,13): error TS6046: Argument for '--target' option must be: 'es3', 'es5', 'es6', 'es2015', 'es2016', 'es2017', 'es2018', 'esnext'. tsconfig.json(7,4): error TS6046: Argument for '--lib' option must be: 'es5', 'es6', 'es2015', 'es7', 'es2016', 'es2017', 'es2018', 'esnext', 'dom', 'dom.iterable', 'webworker', 'scripthost', 'es2015.core', 'es2015.collection', 'es2015.generator', 'es2015.iterable', 'es2015.promise', 'es2015.proxy', 'es2015.reflect', 'es2015.symbol', 'es2015.symbol.wellknown', 'es2016.array.include', 'es2017.object', 'es2017.sharedmemory', 'es2017.string', 'es2017.intl', 'es2017.typedarrays', 'es2018.promise', 'es2018.regexp', 'esnext.array', 'esnext.asynciterable'.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

