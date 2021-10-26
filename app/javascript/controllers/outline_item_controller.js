import { Controller } from "stimulus";
import $ from 'jquery'

export default class extends Controller {
  connect() {}

  submit(event){
    $(event.target).closest('form').find("input[type=submit]").trigger("click");
  }
}