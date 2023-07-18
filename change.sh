#!/bin/sh

# Fix broken link
sed -i '' 's|\[prompt/task/implement.md\](prompt/task/implement.md)|\[prompt/task/feature/implement.md\](prompt/task/feature/implement.md)|' README.md

# Reword the statement
sed -i '' 's|Please remember that this project is designed to write itself.|Remember, we eat our own dog food in this project. This project is designed to write itself.|' README.md

echo "Changes applied to README.md"
