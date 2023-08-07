#!/bin/sh
set -e
goal="Improve documentation for the Junior project"
echo "Plan:"
echo "1. Create descriptor.md to document the prompt descriptor"
echo "2. Update _sidebar.md to link to the new descriptor.md file"
echo "3. Include details about optional and default attributes, and other prompt features"

# Step 1: Create descriptor.md
cat > docs/descriptor.md << 'EOF'
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
EOF

# Step 2: Update _sidebar.md to link to the new descriptor.md file
cat > docs/_sidebar.md << 'EOF'
* [Home](./README.md)
* [Roadmap](./roadmap.md)
* [Web](./web.md)
* [Usage](./usage.md)
* [Prompt Descriptor](./descriptor.md)
EOF

echo "\033[32mDone: $goal\033[0m\n"