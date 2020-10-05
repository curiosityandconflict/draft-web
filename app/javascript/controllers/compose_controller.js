import { Controller } from "stimulus";
import $ from "jquery";

export default class extends Controller {
    static targets = [ "text", "count" ];

    submit(event) {
        if(event.key === " " || event.keyCode === 32){
            const $count = $(this.countTarget);

            const originalCount = parseInt($count.data('original-count'));
            const inProgress = this.textTarget.value.split(/\s+/).length;

            $count.text(`${originalCount + inProgress}`);
        }

        if(event.key === "Enter" || event.keyCode === 13){
            event.preventDefault();

            const {textTarget} = this;

            if( textTarget.value === "") return;

            console.log($(this.element).data('update'));
            if( $(this.element).data('update') === false){
                $(document).find(event.target).closest('form').submit();
            }

            $(document).find('.text-container .text').append(`<div>${textTarget.value}</div>`);

            //TODO: submit
            let formData = new FormData();
            formData.append("session[text]", textTarget.value);

            textTarget.value = '';

            fetch($(this.element).data('session-update-url'), {
                body: formData,
                method: 'PUT',
                dataType: 'script',
                credentials: "include",
                headers: {
                    "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
                }
            })
                .then((response) => {
                    console.log(response);

                })
        }
    }
}