You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

```
./
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── LICENSE.txt
├── README.md
├── change.sh
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...

```
docs/_sidebar.md:
```
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Include this in the sidebar as html if possible!
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">After 34 years of daily CODING, I STOPPED and now only write software in ENGLISH with the Junior AI IDE. So much powerful than naked ChatGPT. <a href="https://t.co/MD1G1kIQte">https://t.co/MD1G1kIQte</a> <a href="https://twitter.com/hashtag/AI?src=hash&amp;ref_src=twsrc%5Etfw">#AI</a> <a href="https://twitter.com/hashtag/development?src=hash&amp;ref_src=twsrc%5Etfw">#development</a> <a href="https://twitter.com/hashtag/JuniorIDE?src=hash&amp;ref_src=twsrc%5Etfw">#JuniorIDE</a> <a href="https://twitter.com/hashtag/ChatGPT?src=hash&amp;ref_src=twsrc%5Etfw">#ChatGPT</a></p>&mdash; Krisztián Schäffer (@tisztamo_x) <a href="https://twitter.com/tisztamo_x/status/1693697665937166701?ref_src=twsrc%5Etfw">August 21, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



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

