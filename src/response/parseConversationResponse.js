import { marked } from 'marked';

export async function parseConversationResponse(response) {
    let previousParagraph = '';
    const results = [];

    // Create a local marked instance
    const localMarked = new marked.Markdown();
    localMarked.use({
        renderer: {
            code(code, lang) {
                results.push({ code, lang, previousParagraph });
                previousParagraph = '';
            },
            paragraph(text) {
                previousParagraph = text;
            }
        }
    });

    localMarked.parse(response);

    return results;
}
