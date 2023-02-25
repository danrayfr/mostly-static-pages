// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import jquery from "jquery";
import * as boostrap from "bootstrap";
import "@popperjs/core";
import "controllers";
import "@hotwired/turbo-rails";

window.jquery = jquery;
window.$ = jquery;
console.log($);
import "trix"
import "@rails/actiontext"
