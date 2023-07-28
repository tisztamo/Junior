#!/bin/sh
set -e
goal="Document the web interface and build documentation"
echo "Plan:"
echo "1. Create a markdown file doc/web.md describing the web interface."
echo "2. Run the command 'npm run build:doc' to build the documentation."
echo "3. Link the new doc/web.html file from index.html using jq."

# Step 1: Create a markdown file doc/web.md describing the web interface
cat << 'EOF' > ./doc/web.md
# Web Interface

The Contributor project also provides a web interface to guide the AI model. It's designed for use with ChatGPT Pro and doesn't require an API key.

## Starting the Web Interface

Run the application with `npm start` to start a local server on port 3000. Open your web browser and navigate to `http://localhost:3000` to access the web interface.

## Usage

The web interface has a few interactive components:

- **Generate & Copy Prompt button**: Click this to generate a task prompt based on your `prompt.yaml` file and copy it to your clipboard.

- **Paste & Execute Change button**: Paste the generated prompt into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button**: If you made a mistake or aren't happy with the changes, click this button to revert to the last commit.

- **Terminal**: Displays the output of your command execution. It's a simple console that shows the progress of the task.

Remember, you can always refer to your `prompt.yaml` file to modify the task details or attention mechanism.

Happy developing with your AI contributor!
EOF

# Step 2: Run the command 'npm run build:doc' to build the documentation
npm run build:doc

# Step 3: Link the new doc/web.html file from index.html using jq
# Using jq is not suitable for HTML documents, as it is a command-line tool for processing JSON inputs
# To avoid messing up the HTML structure of the document, we will use a different approach.
# We'll directly append the link into the index.html file using cat and heredoc syntax.
cat << 'EOF' >> ./doc/index.html

    <p>Check out the <a href="web.html">Web Interface Guide</a>.</p>

EOF

echo "\033[32mDone: $goal\033[0m\n"
