import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["element"]

  toggle(event) {
    event.preventDefault()
    this.elementTarget.classList.toggle("d-none")
  }
}
