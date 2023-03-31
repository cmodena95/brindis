import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="more-info"
export default class extends Controller {
  static values = {
    id: Number
  }

  connect() {
    const link = `<a href="/events/${this.idValue}">Mas info</a>`
    this.element.querySelector(".trix-content > div").insertAdjacentHTML("beforeend", link)
  }
}
