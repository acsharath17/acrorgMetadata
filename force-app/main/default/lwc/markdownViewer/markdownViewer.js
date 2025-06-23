import { LightningElement, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import MARKDOWN_LIB from '@salesforce/resourceUrl/marked';

export default class MarkdownViewer extends LightningElement {
    @api body = '';
    _initialized = false;

    renderedCallback() {
        if (this._initialized) {
            return;
        }
        this._initialized = true;
        loadScript(this, MARKDOWN_LIB).then(() => {
            this.renderMarkdown();
        });
    }

    @api
    renderMarkdown() {
        if (window.Markdown) {
            const md = new window.Markdown(this.body);
            md.render(html => {
                const container = this.template.querySelector('div');
                if (container) {
                    container.innerHTML = html;
                }
            });
        }
    }

    @api
    set value(val) {
        this.body = val;
        if (this._initialized) {
            this.renderMarkdown();
        }
    }

    get value() {
        return this.body;
    }
}
