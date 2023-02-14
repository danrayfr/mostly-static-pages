import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["toggleable"];
  connect() {
    super.connect();
  }

  toggle() {
    console.log(this.toggleableTarget);
    this.toggleableTarget.classList.toggle("hidden");
  }
}
