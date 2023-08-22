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
- installedTools: By default, this includes "npm, jq." Allows the user to mention his tools, e.g. when drawing. The user can create prompt/installedTools.md to overwrite.

### Overwriting Attributes

Users can overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content for any attribute. If both are present, the value in prompt.yaml has preference.

For example, to set a default operating system in a separate file:

```markdown
# prompt/os.md
Debian
```

And then to overwrite it in the prompt.yaml:

```yaml
os: Ubuntu
```

## Attributes referencing .md files

When a yaml attribute refers to an existing file, its content will be used. For example, the line `task: prompt/task/feature/implement.md` in the example yaml refers to an existing markdown file and its content is injected into the task.

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

Prompt parts are markdown template files, and [ejs](https://ejs.co/) runs on them. Attributes from the yaml file are available in the template, e.g., `<%= requirements %>` injects the requirements.

## Custom Attributes

The user can also define custom attributes not listed above. These can be stored in a markdown file and can be injected into prompt template files using the ejs syntax.

For example, to set a new custom attribute called "documentationRequirements":

```markdown
# prompt/documentationRequirements.md
Ensure that all functions are documented.
```

And then it can be injected into the prompt template:

```
<%= documentationRequirements %>
```