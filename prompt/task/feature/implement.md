# Task: Implement a new feature

## Improve prompt structure

The current method of communicating requirements and goals to the AI
through the attention mechanism results in less clear prompts,
because it is not clear which files are dumped in the prompt for modification/reference
and which files are there for communicating task goals and requirements.

An example attention.txt:

./
src/
src/attention/
src/attention/attention.js
prompt/task/refactor/split.md
prompt/format/new_file_version.md

It is not clear from the resulting attention that the files in the prompt directory
contain commands, while the ones in the src are the files to work with.
The problem is even greater when working with doc .md files.

The best way seems to create a prompt descriptor that can describe the task
requirements and refer to an attention file.

Task requirements will be composed of the following:
- task description (what we need to do, what is the expected result)
- output format (e.g. english prose, dumped files, unidiff etc.)

task descriptions and output formats are defined in markdown files to be included in the prompt.

Attention can remain in its current format.

prompt.yaml, "prompt descriptor" example:

task: prompt/task/refactor/split.md
format: prompt/format/new_file_version.md
attention: attention.txt

Modify prompt.js so that it reads and processed the descriptor!

