// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import jquery from "jquery";
import "bootstrap";
import "@popperjs/core";
import "controllers";

window.jquery = jquery;
window.$ = jquery;
console.log($);
import "@hotwired/turbo-rails"
