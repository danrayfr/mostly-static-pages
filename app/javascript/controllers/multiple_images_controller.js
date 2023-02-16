import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="multiple-images"
export default class extends Controller {
  static targets = ["input"];
  connect() {
    console.log("multiple-images-handler");
  }

  preview() {
    var input = this.inputTarget;
    var files = input.files;
    var imgLoc = document.getElementById("Img");
    for (var i = 0; i < files.length; i++) {
      let reader = new FileReader();
      reader.onload = function () {
        let image = document.createElement("img");
        imgLoc.appendChild(image);
        image.style.height = "100px";
        image.src = reader.result;
      };
      reader.readAsDataURL(files[i]);
    }
  }
}
