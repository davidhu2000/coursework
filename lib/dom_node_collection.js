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

module.exports = DOMNodeCollection;
