import createMarkdownRenderer from './createMarkdownRenderer';
import convertDirectory from './convertDirectory';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);
