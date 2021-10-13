import {Controller} from "stimulus";
import $ from "jquery";

export default class extends Controller {
    static targets = ["text", "count", "textView", "form", "headerActions"];

    connect() {
        const {element, formTarget} = this;
        this.scrollToBottom();
    }

    scrollToBottom() {
        const {textViewTarget} = this;
        textViewTarget.scrollTop = textViewTarget.scrollHeight;
    }

    submit(event) {
        const {element, textTarget, countTarget} = this;

        const $count = $(countTarget);
        const originalCount = parseInt(countTarget.getAttribute('data-original-count'));
        const inProgress = textTarget.value.split(/\s+/).length;

        $count.text(`${originalCount + inProgress}`);

        if (event.key === "Enter" || event.keyCode === 13) {
            event.preventDefault();

            if (textTarget.value === "") return;
            
            $(document).find(event.target).closest('form').find("input[type=submit]").trigger("click");
        }
    }
}