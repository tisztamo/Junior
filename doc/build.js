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
