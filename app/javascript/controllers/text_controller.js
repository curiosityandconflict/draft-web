import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "text", "overlay", "copied" ]

    copy() {
        let range = document.createRange();
        range.selectNode(this.textTarget);
        window.getSelection()?.removeAllRanges();
        window.getSelection()?.addRange(range);
        document.execCommand("copy");
        window.getSelection()?.removeAllRanges();

        const {copiedTarget} = this;

        copiedTarget.style.opacity = 1;

        this.hideCopiedMessage();
    }

    hideCopiedMessage() {
        const {copiedTarget} = this;

        setTimeout(() => {
            copiedTarget.style.opacity = 0;
        }, 2000)
    }
}
