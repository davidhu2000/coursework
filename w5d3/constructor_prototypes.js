function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}.`;
};

let cat1 = new Cat('Mrs. Whiskerson', 'Ken');
let cat2 = new Cat('IDGAF', 'KEN');

console.log(cat1.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return `Everyone loves ${this.name}.`;
};

console.log(cat1.cuteStatement());

Cat.prototype.meow = function() {
  return 'Meow';
};

console.log(cat1.meow());
console.log(cat2.meow());

cat1.meow = function() {
  return 'Woof';
};

console.log(cat1.meow());
console.log(cat2.meow());
