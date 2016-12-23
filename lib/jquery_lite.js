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

	window.$l.extend = (mainObj, ...objs) => {
	  objs.forEach( obj => {
	    for(let key in obj) {
	      mainObj[key] = obj[key];
	    }
	  });
	  return mainObj;
	};

	window.$l.ajax = options => {
	  let defaultOptions = {
	    method: 'GET',
	    contentType: 'HTML',
	    data: '',
	    success: (res) => {
	      return res;
	    },
	    error: (err) => {
	      return err;
	    }
	  };

	  options = window.$l.extend(defaultOptions, options);
	  if (options['url'] === undefined) throw 'ajax request require url.';
	  const xhr = new XMLHttpRequest();
	  xhr.open(options['method'], options['url']);

	  xhr.onload = function () {
	    console.log(xhr.status); // for status info
	    console.log(xhr.responseType); //the type of data that was returned
	    console.log(xhr.response); //the actual response. For json api calls, this will be a json string
	  };

	  xhr.send();

	  return xhr.response;
	};


/***/ },
/* 1 */
/***/ function(module, exports) {

	function DOMNodeCollection(elements) {
	  this.elements = elements;
	}

	// DOM Manipulation and Traversal
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
	  let string;

	  if (typeof elements === 'string') {
	    string = elements;
	  } else if (elements instanceof HTMLElement) {
	    string = elements.outerHTML;
	  } else {
	    string = elements.map( el => el.outerHTML ).join('');
	  }

	  this.each ( el => {
	    el.innerHTML += string;
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
	  return new DOMNodeCollection(this.elements[0].children);
	};

	DOMNodeCollection.prototype.parent = function () {
	  return new DOMNodeCollection([this.elements[0].parentNode]);
	};

	DOMNodeCollection.prototype.find = function (selector) {
	  return new DOMNodeCollection(this.elements[0].querySelectorAll(selector));
	};

	DOMNodeCollection.prototype.remove = function (selector) {
	  this.each ( node => node.parentNode.removeChild(node) );
	};

	// Emuerables
	DOMNodeCollection.prototype.each = function (callback) {
	  this.elements.forEach(callback);
	};

	DOMNodeCollection.prototype.map = function (callback) {
	  return this.elements.map(callback);
	};

	// Event handling

	DOMNodeCollection.prototype.on = function (eventName, callback) {
	  this.elements[0].addEventListener(eventName, callback);
	};

	DOMNodeCollection.prototype.off = function (eventName, callback) {
	  this.elements[0].removeEventListener(eventName);
	};

	module.exports = DOMNodeCollection;


/***/ }
/******/ ]);