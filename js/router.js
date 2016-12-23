function Router(node) {
  this.node = node;
}

Router.prototype.start = function () {
  document.addEventListener('hashchange', this.render());
};

Router.prototype.render = function () {
  this.node.innerHTML = '';
  let current = this.activeRoute();
  let p = document.createElement('p');
  p.innerHTML = current;
  this.node.append(p);
};

Router.prototype.activeRoute = function () {
  return location.hash.replace('#','');
};

module.exports = Router;
