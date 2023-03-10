import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["toggleable", "menu"];
  connect() {}

  toggle() {
    this.toggleableTarget.classList.toggle("show");
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("show");
  }
}
