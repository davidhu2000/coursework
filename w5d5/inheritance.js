Function.prototype.inherits = function (parent) {
  function Surrogate () {}
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject (name, color) {
  this.name = name;
  this.color = color;
}

MovingObject.prototype.print = function() {
  console.log('printing');
};

function Ship (name, color, model) {
  // this.name = name;
  MovingObject.call(this, name, color);
  this.model = model;
}
Ship.inherits(MovingObject);

Ship.prototype.loadPassenger = function() {
  console.log('loading passengers');
};

function Asteroid (name, color, size) {
  MovingObject.call(this, name, color);
  this.size = size;
}
Asteroid.inherits(MovingObject);

Asteroid.prototype.move = function() {
  console.log('moving');
};

const m = new MovingObject ('obj', 'orange');

const s = new Ship ('Ship', 'white', 'Battleship');

const a = new Asteroid ('Astroid', 'black', '5000');

s.print();
a.print();

s.loadPassenger();

a.move();

// s.move();
