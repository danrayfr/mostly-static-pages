// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application";

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
// eagerLoadControllersFrom("controllers", application);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading";
// lazyLoadControllersFrom("controllers", application);

// import HelloController from "./hello_controller";
// application.register("hello", HelloController);

import DropdownController from "./dropdown_controller";
application.register("dropdown", DropdownController);

import MultipleImagesController from "./multiple_images_controller";
application.register("multiple_images", MultipleImagesController);

import CarouselController from "./carousel_controller";
application.register("carousel", CarouselController);
