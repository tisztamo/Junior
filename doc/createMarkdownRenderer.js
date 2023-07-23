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
