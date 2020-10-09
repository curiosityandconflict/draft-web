import { Controller } from "stimulus";

export default class extends Controller {
    static targets = [ "text", "overlay" ];

    copy() {
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
