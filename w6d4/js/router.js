function Router(node, routes) {
  this.node = node;
  this.routes = routes;
}

Router.prototype.start = function () {
  document.addEventListener('hashchange', this.render());
};

Router.prototype.render = function () {
  this.node.innerHTML = '';
  let node = this.activeRoute();
  console.log(node.render());
  let p = document.createElement('p');
  p.appendChild(node.render());
  this.node.append(p);
};

Router.prototype.activeRoute = function () {
  let component = location.hash.toLowerCase().replace('#','');
  if (component === '') component = 'inbox';
  return this.routes[component];
};

module.exports = Router;
