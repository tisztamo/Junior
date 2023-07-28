# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── src/...

```
```
doc/
├── example.html
├── example.md
├── index.html
├── introduction.html
├── introduction.md

```
doc/index.html:
```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Documentation</title>
  </head>
  <body>
    <h1>Welcome to our documentation!</h1>
    <p>Start with the <a href="introduction.html">introduction</a>.</p>
  </body>
</html>

```

doc/example.md:
```
# Example
This is an example of our documentation.

```

doc/example.html:
```
<h1>Example</h1>
<p>This is an example of our documentation.</p>

```

./README.md:
```
Warn: This README is AI generated, just like all the source files of this project.

# The Junior - Your AI contributor which writes itself.

## Description

The Contributor is an exploratory project aimed at revolutionizing the way programmers interact with the development process. Just like how Linus Torvalds oversees the Linux Kernel development without coding himself, this project allows developers to communicate with the AI and supervise the development process.

By providing specific task details in a prompt descriptor and highlighting the relevant parts of your project, you can delegate code implementation, documentation, testing, and more to your AI Contributor.

## Getting Started

### Installation

To install, clone the repository and run `npm install` in the root directory.

### Usage

There are two ways to use this project: a command-line interface (CLI) and a web interface.

#### Command-line interface (CLI)

To start the CLI, use `npm run cli`. This mode uses the ChatGPT API, and you'll need an API key stored in the `OPENAI_API_KEY` environment variable.

#### Web Interface

Run the application with `npm start` to start a local server on port 3000, where you can generate a prompt and automatically copy it to paste into ChatGPT. The web interface is designed for use with ChatGPT Pro and doesn't require an API key.

### The Prompt Descriptor

A prompt descriptor is a YAML file (`prompt.yaml`) outlining the details necessary for generating a task prompt for the AI model.

Here's an example of a prompt descriptor:

```yaml
task: prompt/task/feature/implement.md
attention:
  - src/interactiveSession/startInteractiveSession.js
  - src/prompt/createPrompt.js
  - src/attention/readAttention.js
  - prompt.yaml
requirements: >
  Write a README.md for this _exploratory_ project!
format: prompt/format/new_file_version.md
```

Each element in the descriptor serves a specific purpose:
- `task`: Describes the task type and scope. For example, `feature/implement`, `bug/fix`, or `refactor/`. You can check out the [prompt/task/feature/implement.md](prompt/task/feature/implement.md) file as an example.
- `attention`: Lists the files and directories most relevant to the task.
- `requirements`: Describes the actual task in a human-readable format.
- `format`: Determines how the output will be formatted.

### Attention Mechanism

The attention mechanism guides the AI model by providing it with a working set. It helps overcome the limited working memory of large language models.

The working set is a subset of the entire project that's currently in focus. It includes both files and directories. For files, the content is directly provided to the AI. For directories, a brief list of files and subdirectories within them is presented.

## Contributing and Support

Contributions are welcome! Remember, we eat our own dog food in this project. This project is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.
```


# Task

Improve the documentation!

Document the web interface in doc/web.md and npm run build:doc! Link it from index.html!
Read README.md carefully, but do not assume the reader knows it, and do not edit it!


&lt;/div&gt;&lt;/div&gt;&lt;button class=&#34;w-64 px-4 py-4 bg-blue-500 text-white rounded&#34;&gt;Generate &amp;amp; Copy Prompt&lt;/button&gt;&lt;details class=&#34;w-full max-w-screen overflow-x-auto whitespace-normal markdown&#34; style=&#34;display: none;&#34;&gt;&lt;summary&gt;prompt length: 0 chars&lt;/summary&gt;&lt;div&gt;&lt;/div&gt;&lt;/details&gt;&lt;button class=&#34;w-64 px-4 py-4 bg-orange-300 text-white rounded&#34;&gt;Paste &amp;amp; Execute Change&lt;/button&gt;&lt;div class=&#34;rounded overflow-auto max-w-full hidden&#34;&gt;&lt;div dir=&#34;ltr&#34; class=&#34;terminal xterm xterm-dom-renderer-owner-1&#34;&gt;&lt;div class=&#34;xterm-viewport&#34; style=&#34;background-color: rgb(0, 0, 0);&#34;&gt;&lt;div class=&#34;xterm-scroll-area&#34;&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class=&#34;xterm-screen&#34; style=&#34;width: 0px; height: 0px;&#34;&gt;&lt;div class=&#34;xterm-helpers&#34;&gt;&lt;textarea class=&#34;xterm-helper-textarea&#34; aria-label=&#34;Terminal input&#34; aria-multiline=&#34;false&#34; autocorrect=&#34;off&#34; autocapitalize=&#34;off&#34; spellcheck=&#34;false&#34; tabindex=&#34;0&#34;&gt;&lt;/textarea&gt;&lt;span class=&#34;xterm-char-measure-element&#34; aria-hidden=&#34;true&#34; style=&#34;font-family: courier-new, courier, monospace; font-size: 15px;&#34;&gt;W&lt;/span&gt;&lt;div class=&#34;composition-view&#34;&gt;&lt;/div&gt;&lt;/div&gt;&lt;style&gt;.xterm-dom-renderer-owner-1 .xterm-rows span { display: inline-block; height: 100%; vertical-align: top; width: 0px}&lt;/style&gt;&lt;style&gt;.xterm-dom-renderer-owner-1 .xterm-rows { color: #ffffff; font-family: courier-new, courier, monospace; font-size: 15px;}.xterm-dom-renderer-owner-1 .xterm-rows .xterm-dim { color: #ffffff80;}.xterm-dom-renderer-owner-1 span:not(.xterm-bold) { font-weight: normal;}.xterm-dom-renderer-owner-1 span.xterm-bold { font-weight: bold;}.xterm-dom-renderer-owner-1 span.xterm-italic { font-style: italic;}@keyframes blink_box_shadow_1 { 50% {  box-shadow: none; }}@keyframes blink_block_1 { 0% {  background-color: #ffffff;  color: #000000; } 50% {  background-color: #000000;  color: #ffffff; }}.xterm-dom-renderer-owner-1 .xterm-rows:not(.xterm-focus) .xterm-cursor.xterm-cursor-block ,.xterm-dom-renderer-owner-1 .xterm-rows:not(.xterm-focus) .xterm-cursor.xterm-cursor-bar ,.xterm-dom-renderer-owner-1 .xterm-rows:not(.xterm-focus) .xterm-cursor.xterm-cursor-underline { outline: 1px solid #ffffff; outline-offset: -1px;}.xterm-dom-renderer-owner-1 .xterm-rows.xte #00000080; }.xterm-dom-renderer-owner-1 .xterm-bg-257 { background-color: #ffffff; }&lt;/style&gt;&lt;div class=&#34;xterm-rows&#34; aria-hidden=&#34;true&#34; style=&#34;line-height: normal;&#34;&gt;&lt;div style=&#34;width: 0px; height: 0px; line-height: 0px; overflow: hidden;&#34;&gt;&lt;span class=&#34;xterm-cursor xterm-cursor-block&#34;&gt; &lt;/span&gt;&lt;/div&gt;&lt;div class=&#34;xterm-decoration-container&#34;&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;pre class=&#34;rounded overflow-auto max-w-full block&#34;&gt; M prompt.md&lt;br&gt; M prompt.yaml&lt;br&gt;&lt;/pre&gt;&lt;button class=&#34;w-64 px-4 py-4 bg-red-700 text-white rounded&#34;&gt;Roll Back to Last Commit&lt;/button&gt;&lt;/div&gt;


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

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

