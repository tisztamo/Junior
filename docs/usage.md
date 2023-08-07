# Developing External Projects with Junior

## Installation

Install Junior as a development dependency by running the following command:

```
npm add @aijunior/dev --save-dev
```

## Initialization

You can initialize the necessary files in the repository with the command:

```
npx junior-init
```

This will create the following files:

```
ko@MacBook-Pro-5 x % npx junior-init
Initialized empty Git repository in /Users/ko/projects-new/tmp/juniortest/x/.git/
[master (root-commit) 5c5c155] Junior init
2 files changed, 6 insertions(+)
create mode 100644 .gitignore
create mode 100644 prompt/projectSpecifics.md
Repo initialized for Junior development
ko@MacBook-Pro-5 x % ls -a . .. .git .gitignore prompt prompt.yaml
ko@MacBook-Pro-5 x % ls -a prompt . .. projectSpecifics.md
```

The prompt files will be gitignored.

### Project Specifics

`prompt/projectSpecifics.md` is used to provide instructions about the codebase that Junior is working on, like preferred tools. It is important to keep this file minimal as it will be included in most prompts, and unnecessary complexity may result in the language model losing track and failing to solve the task.

## Starting Junior

You can start Junior with:

```
npx junior-web
```

For more information about the web interface, please refer to [web.md](./web.md).
