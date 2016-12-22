/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const DOMNodeCollection = __webpack_require__(1);

	window.$l = element => {
	  let nodes;
	  if (element instanceof HTMLElement) {
	    nodes = element;
	  } else if (typeof element === 'string') {
	    nodes = document.querySelectorAll(element);
	  }
	  nodes = [].slice.call(nodes);
	  return new DOMNodeCollection(nodes);
	};


/***/ },
/* 1 */
/***/ function(module, exports) {

	function DOMNodeCollection(elements) {
	  this.elements = elements;
	}

	DOMNodeCollection.prototype.html = function (string) {
	  let that = this;
	  if (typeof string === 'string') {
	    this.elements.forEach( el => {
	      el.innerHTML = string;
	    });
	  } else {
	    return that.elements[0].innerHTML;
	  }
	};

	DOMNodeCollection.prototype.empty = function () {
	  this.html('');
	};

	DOMNodeCollection.prototype.append = function (elements) {
	  this.elements.forEach ( el => {
	    el.innerHTML += elements;
	  });
	};

	DOMNodeCollection.prototype.addClass = function (className) {
	  this.className += className;
	};

	DOMNodeCollection.prototype.removeClass = function (className) {
	  this.className.replace(className, '');
	};

	DOMNodeCollection.prototype.attr = function (attribute, value) {
	  if (value === undefined) {
	    this.getAtrribute(attribute);
	  } else {
	    this.setAttributes(attribute, value);
	  }
	};

	DOMNodeCollection.prototype.children = function () {
	  return this.elements[0].children;
	};

	DOMNodeCollection.prototype.parent = function () {
	  return [this.elements[0].parentNode];
	};

	DOMNodeCollection.prototype.find = function (selector) {
	  return this.elements[0].querySelectorAll(selector);
	};

	DOMNodeCollection.prototype.remove = function (selector) {
	  this.each ( node => node.parentNode.removeChild(node) );
	};

	module.exports = DOMNodeCollection;


/***/ }
/******/ ]);