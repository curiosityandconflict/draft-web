import { Controller } from "stimulus";
import $ from "jquery";

export default class extends Controller {
    static targets = [ "text", "count" ];

    submit(event) {
        if(event.key === " " || event.keyCode === 32){
            console.log($(this.countTarget).text());
            console.log(parseInt($(this.countTarget).text()))
        }

        if(event.key === "Enter" || event.keyCode === 13){
            event.preventDefault();

            const {textTarget} = this;

            if( textTarget.value === "") return;
            // $(document).find(event.target).closest('form').submit();

            $(document).find('.text-container .text').append(`<div>${textTarget.value}</div>`)

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