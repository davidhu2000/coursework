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
