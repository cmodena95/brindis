import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slide"
export default class extends Controller {
  static targets = ["background", "menu", "overlay"]

  display() {
    this.backgroundTarget.classList.toggle("bg-fixed")
    this.menuTarget.classList.toggle("menu-display")
    this.overlayTarget.classList.toggle("d-none")
  }

  close(event) {
    this.backgroundTarget.classList.remove("bg-fixed")
    this.menuTarget.classList.remove("menu-display")
    event.currentTarget.classList.add("d-none")
  }
}
