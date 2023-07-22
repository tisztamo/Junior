#!/bin/sh
# Goal: Setup documentation with GitHub Pages
# Plan:
# 1. Remove everything from the doc directory
# 2. Create a new directory hierarchy for the documentation
# 3. Install documentation tools
# 4. Add markdown examples
# 5. Configure GitHub Pages
# 6. Run build process to generate HTML from markdown

# Step 1: Remove everything from the doc directory
rm -rf ./doc/*

# Step 2: Create a new directory hierarchy for the documentation
mkdir -p ./doc/api ./doc/getting-started ./doc/examples

# Step 3: Install documentation tools
# We'll use markdown-it for converting markdown to HTML,
# and highlight.js for code highlighting in the generated HTML

npm install --save-dev markdown-it highlight.js

# Create a script to convert the markdown files to HTML
cat << EOF > ./doc/build.js
import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';
import MarkdownIt from 'markdown-it';
import hljs from 'highlight.js';

const md = new MarkdownIt({
  html: true,
  linkify: true,
  typographer: true,
  highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(str, { language: lang }).value;
      } catch (__) {}
    }
    return ''; 
  }
});

const convertDirectory = (dir) => {
  const files = readdirSync(dir);
  files.forEach(file => {
    const filePath = join(dir, file);
    const stats = statSync(filePath);
    if (stats.isDirectory()) {
      convertDirectory(filePath);
    } else if (extname(file) === '.md') {
      const markdown = readFileSync(filePath, 'utf8');
      const html = md.render(markdown);
      writeFileSync(filePath.replace('.md', '.html'), html);
    }
  });
}

convertDirectory('./doc');
EOF

# Add the doc build script to package.json scripts
jq '.scripts += {"build:docs": "node ./doc/build.js"}' package.json > package.json.temp
mv package.json.temp package.json

# Step 4: Add markdown examples

cat << EOF > ./doc/introduction.md
# Introduction
This is the introduction to our documentation. Check out our [example](example.html) for more details.
EOF

cat << EOF > ./doc/example.md
# Example
This is an example of our documentation.
EOF

# Step 5: Configure GitHub Pages
# GitHub Pages will serve files from the doc directory on the gh-pages branch
# We can configure this in the repository settings on GitHub

echo "Please configure GitHub Pages in your repository settings to serve files from the 'doc' directory on the 'gh-pages' branch."

# Create an empty .nojekyll file to tell GitHub Pages not to use Jekyll
touch ./doc/.nojekyll

# Step 6: Add index.html
cat << EOF > ./doc/index.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Documentation</title>
  </head>
  <body>
    <h1>Welcome to our documentation!</h1>
    <p>Start with the <a href="introduction.html">introduction</a>.</p>
  </body>
</html>
EOF

# Run build process to generate HTML from markdown
npm run build:docs
