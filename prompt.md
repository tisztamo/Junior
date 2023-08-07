# Working set

docs/descriptor.md:
```
# Prompt Descriptor

The prompt descriptor is a YAML file (`prompt.yaml`) that outlines the details necessary for generating a task prompt for the AI model. It is used to specify the task, attention, requirements, and other attributes.

## Example

```yaml
task: prompt/task/feature/implement.md
attention:
  - src/interactiveSession/startInteractiveSession.js
  - src/prompt/createPrompt.js
  - src/attention/readAttention.js
  - prompt.yaml
requirements: >
  Write a README.md for this _exploratory_ project!
```

## Attributes

- `task`: Describes the task type and scope.
- `attention`: Lists the files and directories most relevant to the task.
- `requirements`: Describes the actual task in a human-readable format.
- `format`: (Optional and half-working) Determines how the output will be formatted. It should be avoided for now.
- `os`: (Default: "Debian") Specifies the operating system.
- `installedTools`: Allows to overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content.

## Template Files

Prompt parts are markdown template files, and [ejs](https://ejs.co/) runs on them. Attributes from the yaml file are available in the template, e.g., `<%= requirements %>` injects the requirements.

When a yaml attribute refers to an existing file, its content will be used.

```

prompt/task/feature/implement.md:
```
Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

<%= requirements %>

<%= projectSpecifics %>
```


# Task

Improve the documentation!

In docs/descriptor.md, instead of just &#34;When a yaml attribute refers to an existing file, its content will be used.&#34;, make a whole section: &#34;Attributes referencing .md files&#34;! - Put it between &#34;Attributes&#34; and &#34;Template Files&#34; - Also write about an example in the new section: the task: prompt/task/feature/implement.md line in the example yaml - Show the content of prompt/task/feature/implement.md to supplement the example


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

