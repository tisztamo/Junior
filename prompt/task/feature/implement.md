Implement the following feature!

- Write a plan before the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

The attention consists of files and listed directories.
We will improve it by printing a PARTIAL folder structure instead of listing all directories.

## Example

A sample prompt descriptor:

```yaml
task: prompt/task/feature/implement.md
format: prompt/format/new_file_version.md
attention:
  - ./
  - prompt/
  - src/
  - src/attention/readAttention.js
```

This should generate the following output:

```
/
├── doc/...
├── node_modules/...
├── package.json
├── prompt/
│   ├── attention-cache/...
│   ├── format/...
│   ├── prompt-drill.yaml
│   ├── prompt-list.yaml
│   ├── system.md
│   ├── system.md.old
│   └── task/...
├── secret.sh
├── src/
│   ├── attention/...
│   ├── config.js
│   ├── execute/...
│   ├── interactiveSession/
│   │   ├── handleApiResponse.js
│   │   ├── printNewtext.js
│   │   ├── saveAndSendPrompt.js
│   │   └── startInteractiveSession.js
│   ├── main.js
│   ├── prompt/...
│   └── utils/...
└── tmp/...

src/attention/readAttention.js:
[contents of readAttention.js]

Notes:

 - Use the special characters ├ and │ to show the levels of the hierarchy!
 - Only list directories mentioned in the descriptor, do not recurse!
 - While listing a dir, list both files and subdirs, but mark subdirs with / at the end of the line!
 - While listing a dir, if found a subdir not mentioned in the descriptor, mark it with /... at the end of the line!
