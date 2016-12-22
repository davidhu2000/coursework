const DOMNodeCollection = require('./dom_node_collection.js');

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
