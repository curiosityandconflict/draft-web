import { Controller } from "stimulus";
import $ from "jquery";

export default class extends Controller {
    static targets = [ "text" ];

    submit(event) {
        if(event.key === "Enter" || event.keyCode === 13){
            event.preventDefault();

            if( this.textTarget.value === "") return;
            $(document).find(event.target).closest('form').submit();
        }
    }
}