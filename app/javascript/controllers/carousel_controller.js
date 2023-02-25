import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["main"];
  static values = {
    images: Array,
  };
  connect() {}

  click(e) {
    const url = e.params.url;
    this.mainTarget.innerHTML = `<img src="${url}" class="d-block w-100" style="width:500px;height:600px;">`;
  }
}
