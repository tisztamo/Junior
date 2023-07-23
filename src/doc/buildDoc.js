import convertDirectory from './convertDirectory';
import createMarkdownRenderer from './createMarkdownRenderer';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);
