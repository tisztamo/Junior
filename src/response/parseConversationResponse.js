import { Marked } from 'marked';

export async function parseConversationResponse(response) {
    const localMarked = new Marked();
    let previousParagraph = '';
    const results = [];

    // Configure the localMarked instance with custom renderer
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
