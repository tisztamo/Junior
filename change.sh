#!/bin/sh
# Goal: Fix relative imports by adding .js
# Plan:
# 1. Modify the src/doc/buildDoc.js file to correct the relative imports by adding '.js'
# 2. Modify the src/doc/convertDirectory.js file to correct the relative imports by adding '.js'

cat > src/doc/buildDoc.js << 'EOF'
import convertDirectory from './convertDirectory.js';
import createMarkdownRenderer from './createMarkdownRenderer.js';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);
EOF

cat > src/doc/convertDirectory.js << 'EOF'
import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';
import createMarkdownRenderer from './createMarkdownRenderer.js';

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

