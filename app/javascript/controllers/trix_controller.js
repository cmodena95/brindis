import { Controller } from "@hotwired/stimulus"
import Trix from "trix"

// Connects to data-controller="trix"
export default class extends Controller {
  connect() {
    document.addEventListener("trix-before-initialize", () => {
      // Change Trix.config if you need
    })
  }
}
