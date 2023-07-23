import convertDirectory from './convertDirectory.js';
import createMarkdownRenderer from './createMarkdownRenderer.js';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);
