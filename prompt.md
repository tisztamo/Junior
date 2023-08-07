# Working set

docs/descriptor.md:
```
# Prompt Descriptor

The prompt descriptor is a YAML file (prompt.yaml) that outlines the details necessary for generating a task prompt for the AI model. It is used to specify the task, attention, requirements, and other attributes.

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

- task: Describes the task type and scope.
- attention: Lists the files and directories most relevant to the task.
- requirements: Describes the actual task in a human-readable format.
- format: (Optional and half-working) Determines how the output will be formatted. It should be avoided for now.
- os: (Default: "Debian") Specifies the operating system.
- installedTools: Allows to overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content.

## Attributes referencing .md files

When a yaml attribute refers to an existing file, its content will be used. For example, the line task: prompt/task/feature/implement.md in the example yaml refers to an existing markdown file and its content is injected into the task.

Here's the content of prompt/task/feature/implement.md as a supplement to the example:

```
Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

<%= requirements %>

<%= projectSpecifics %>
```

## Template Files

Prompt parts are markdown template files, and [ejs](https://ejs.co/) runs on them. Attributes from the yaml file are available in the template, e.g., <%= requirements %> injects the requirements.


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

In docs/descriptor.md, fix &#34;- installedTools: Allows to overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content.&#34;! installedTools is by default &#34;npm, jq&#34;, and the user can mention his tools in prompt/installedTools.md. Also mention that the user can overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content for any attribute, including ones not listed here.  


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

