import {Controller} from "stimulus";
import $ from "jquery";
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = ["text", "count", "textView", "form", "headerActions"];
    form_url="";
    update=false;

    connect() {
        const {element, formTarget} = this;
        this.scrollToBottom();

        $(formTarget).submit(event => event.preventDefault());

        this.form_url = $(element).data('session-update-url');
        this.update = $(element).data('update');
    }

    scrollToBottom() {
        const {textViewTarget} = this;
        textViewTarget.scrollTop = textViewTarget.scrollHeight;
    }

    getHeaderActions(id) {
        const {headerActionsTarget} = this;

        Rails.ajax({
            url: `/writing_sessions/${id}/header_actions`,
            datatype: 'script',
            type: `GET`,
            success: (data) => {
                console.log(data)
                headerActionsTarget.innerHTML = data.body.innerHTML;
            },
            error: (error) => {
                console.log('ERROR:' + error)
            }
        })

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

            console.log($(element).data('update'));
            if ($(element).data('update') === false) {
                $(document).find(event.target).closest('form').submit();
            }

            $(document).find('.text-container .text').append(`<div>${textTarget.value}</div>`);

            this.scrollToBottom();

            let formData = new FormData();
            formData.append("session[text]", textTarget.value);
            textTarget.value = '';
            const url = `${this.form_url}.json`;

            Rails.ajax({
                url: url,
                datatype: 'script',
                data: formData,
                type: `${this.update ? 'PUT' : 'POST'}`,
                success: (data) => {
                    const {word_count, id, text} = data;
                    $(countTarget).text(word_count);
                    countTarget.setAttribute('data-original-count', word_count);

                    //update form route
                    if(!this.update){
                        this.getHeaderActions(id);
                    }
                    this.form_url = `/writing_sessions/${id}`;
                    //switch to put instead of post
                    this.update = true;
                    //push new route into browser
                    window.history.pushState({},'',`/writing_sessions/${id}/edit`)

                },
                error: (error) => {
                    console.log('ERROR:' + error)
                }
            })
        }
    }
}