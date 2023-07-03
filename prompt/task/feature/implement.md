Implement the following feature!

- Write a plan before the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

Requirements:

When creating prompts from the yaml descriptor, injecting arbitrary values into the
markdown files would be great! E.g. the "requirements" key is not parsed currently,
but it would be nice for the implement.md (This markdown file injected into the current prompt) to allow us simply write ${requirements}
in ES6 style.

Notes:

Idea: ejs is what we need. All uknown keys in the yaml should be made available for a ejs template.
This template is used instead of the markdown files. The template, when filled out, reveals a markdown, which will be injected to the prompt.

Test: <%= requirements%>