import { Controller } from "stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs"


export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150,
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    let id = event.item.dataset.id || event.item.firstElementChild.dataset.id
    let data = new FormData()
    data.append("outline_item[position]", event.newIndex + 1)

    let url = event.target.dataset.url

    Rails.ajax({
      url: url.replace(":id", id),
      type: 'PATCH',
      data: data
    })
  }
}