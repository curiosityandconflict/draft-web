import { Controller } from "stimulus";
import $ from "jquery";
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = [ "text", "count", "textView" ];

    connect(){
        console.log('scroll to bottom');
        this.scrollToBottom();
    }

    scrollToBottom(){
        const {textViewTarget} = this;
        textViewTarget.scrollTop = textViewTarget.scrollHeight;
    }



    submit(event) {
        const {element, textTarget, countTarget} = this;

        // if(event.key === " " || event.keyCode === 32){
            const $count = $(countTarget);

            const originalCount = parseInt($count.data('original-count'));
            const inProgress = textTarget.value.split(/\s+/).length;

            $count.text(`${originalCount + inProgress}`);
        // }

        if(event.key === "Enter" || event.keyCode === 13){
            event.preventDefault();

            if( textTarget.value === "") return;

            console.log($(element).data('update'));
            if( $(element).data('update') === false){
                $(document).find(event.target).closest('form').submit();
            }

            $(document).find('.text-container .text').append(`<div>${textTarget.value}</div>`);

            this.scrollToBottom();
            // $(document).find(event.target).closest('form').submit();

            //TODO: submit
            let formData = new FormData();
            formData.append("session[text]", textTarget.value);

            textTarget.value = '';

            const url = $(this.element).data('session-update-url');
            if(url.includes('new')){

            }

            Rails.ajax({
                url: `${$(this.element).data('session-update-url')}${url.includes('edit') ? '.json' : ''}`,
                datatype: 'script',
                data: formData,
                type: `${url.includes('edit') ? 'put' : 'post'}`,
                success: (data) => {
                    console.log('data:' + data);
                    $(this.countTarget).text(data.word_count).data('original-count', data.word_count)
                },
                error: (error) => {
                    console.log('ERROR:'+error)
                }
            })
        }
    }
}