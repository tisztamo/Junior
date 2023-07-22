#!/bin/sh
# Add the doc build script to package.json scripts
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

# Change the permission of the script to make it executable
chmod +x ./doc/build.js

# Add the doc build script to package.json scripts
jq '.scripts += {"build:docs": "node ./doc/build.js"}' package.json > package.json.temp
mv package.json.temp package.json

#!/bin/sh

# Add markdown examples
cat << EOF > ./doc/introduction.md
# Introduction
This is the introduction to our documentation. Check out our [example](example.html) for more details.
EOF

cat << EOF > ./doc/example.md
# Example
This is an example of our documentation.
EOF
