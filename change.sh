#!/bin/sh
# Goal: Refactor build.js into separate files and pass MarkdownIt as an argument
# Plan:
# 1. Rename build.js to buildDoc.js
# 2. Create a new file, createMarkdownRenderer.js, that handles the creation of MarkdownIt
# 3. Create a new file, convertDirectory.js, that handles directory conversion
# 4. Modify convertDirectory.js to accept MarkdownIt as an argument

# Step 1
mv ./doc/build.js ./doc/buildDoc.js

# Step 2
cat << EOF > ./doc/createMarkdownRenderer.js
import MarkdownIt from 'markdown-it';
import hljs from 'highlight.js';

export default function createMarkdownRenderer() {
    return new MarkdownIt({
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
}
EOF

# Step 3
cat << EOF > ./doc/convertDirectory.js
import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';
import createMarkdownRenderer from './createMarkdownRenderer';

export default function convertDirectory(dir, md = createMarkdownRenderer()) {
    const files = readdirSync(dir);
    files.forEach(file => {
        const filePath = join(dir, file);
        const stats = statSync(filePath);
        if (stats.isDirectory()) {
            convertDirectory(filePath, md);
        } else if (extname(file) === '.md') {
            const markdown = readFileSync(filePath, 'utf8');
            const html = md.render(markdown);
            writeFileSync(filePath.replace('.md', '.html'), html);
        }
    });
}
EOF

# Step 4: Update the buildDoc.js
cat << EOF > ./doc/buildDoc.js
import createMarkdownRenderer from './createMarkdownRenderer';
import convertDirectory from './convertDirectory';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);
EOF
