import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["toggleable"];
  connect() {
    super.connect();
    console.log("Connecting to data-controller");
  }

  toggle() {
    console.log(this.toggleableTarget);
    this.toggleableTarget.classList.toggle("hidden");
  }
}
