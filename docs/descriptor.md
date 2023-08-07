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
