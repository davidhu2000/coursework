// function sum() {
//   return Array.prototype.slice.call(arguments).reduce( (total, el) => {
//     return total + el;
//   });
// }

// function sum(...nums) {
//   return nums.reduce( (total, el) => {
//     return total + el;
//   });
// }

// console.log(sum(1,2,3,4));

Object.prototype.myBind = function(object) {
  let that = this;
  let bindArgs = Array.prototype.slice.call(arguments, 1);
  return function () {
    let internalArgs = Array.prototype.slice.call(arguments, 0);
    let args = Array.prototype.concat(bindArgs, internalArgs);
    return that.apply(object, args);
  };
};

Function.prototype.myBind = function(object, ...bindArgs) {
  let that = this;
  return function (...internalArgs) {
    let args = Array.prototype.concat(bindArgs, internalArgs);
    return that.apply(object, args);
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true

/* curriedSum */

function curriedSum(numArgs) {
  let numbers = [];

  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return numbers.reduce ( (total, el) => total + el );
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
}

// const sum = curriedSum(4);
// let res = sum(5)(30)(20)(1); // => 56
// console.log(res);

Function.prototype.curry = function(numArgs) {
  let numbers = [];
  let that = this;
  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      // return that.apply(null, numbers);
      return that(...numbers);
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30
console.log(f1);
// or more briefly:
let sum = sumThree.curry(3)(4)(20)(6); // == 30
console.log(sum);
