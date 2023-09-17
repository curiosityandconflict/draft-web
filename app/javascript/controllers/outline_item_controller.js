import { Controller } from "@hotwired/stimulus"
import $ from 'jquery'

export default class extends Controller {
  static targets = ["text"];

  connect() {
    var self = this;
    this.textTarget.addEventListener("keyup", (event) => {
      const currentHeight = parseInt(self.textTarget.style.height)
      if(event.code !== 'Backspace'){
        if(currentHeight < self.textTarget.scrollHeight)
          self.textTarget.style.height = self.textTarget.scrollHeight + 30 + "px";
      }
    });
  }

  textTargetConnected(el) {
    el.style.height = el.scrollHeight + 30 + "px";
  }

  submit(event){
    $(event.target).closest('form').find("input[type=submit]").trigger("click");
  }
}