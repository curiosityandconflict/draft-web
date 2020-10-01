import { Controller } from "stimulus";
import $ from "jquery";

export default class extends Controller {
    static targets = [ "text", "overlay" ];

    connect() {
        console.log('scroll to bottom');

        const scrollToBottom = this.element.getAttribute('data-scroll-to-bottom') === "true";

        if(scrollToBottom) {
            this.element.scrollTop = this.element.scrollHeight;
        }
    }

    copy() {
        const enableCopy = this.element.getAttribute('data-enable-copy') === 'true';
        if(!enableCopy) return;

        let range = document.createRange();
        range.selectNode(this.textTarget);
        window.getSelection()?.removeAllRanges();
        window.getSelection()?.addRange(range);
        document.execCommand("copy");
        window.getSelection()?.removeAllRanges();

        const {overlayTarget} = this;

        const originalStyles = overlayTarget.style;

        overlayTarget.style.zIndex= '1';
        overlayTarget.style.opacity= '1';

        setTimeout(() => {
            overlayTarget.style=originalStyles;
        }, 2000)
    }
}
