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
