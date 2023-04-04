import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slide"
export default class extends Controller {
  static targets = ["background", "menu"]

  display() {
    this.backgroundTarget.classList.toggle("bg-fixed")
    this.menuTarget.classList.toggle("menu-display")
  }
}
