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
