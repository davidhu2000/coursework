function uniq(array) {
  let uniqArray = [];
  for(let i = 0; i < array.length; i++) {
    if(uniqArray.indexOf(array[i]) === -1) {
      uniqArray.push(array[i]);
    }
  }
  return uniqArray;
}

// console.log(uniq([1,2,3,2,1,2,3,3,2,1,1]));

function twoSum(array) {
  let res = [];
  for(let idx in array) {
    let toFind = -1 * array[idx];
    let toFindIdx = array.indexOf(toFind);
    if(toFindIdx !== -1 && toFindIdx > idx) {
      res.push([idx, toFindIdx]);
    }
  }
  return res;
}

// console.log(twoSum([-1,0,2,-2,1]));

function transpose(matrix) {
  let res = [];
  for(let row in matrix[0]) {
    res[row] = [];
    for(let col in matrix) {
      res[row][col] = matrix[col][row];
    }
  }
  return res;
}

const rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

// console.log(transpose(rows));


function myEach(array, callback) {
  for(let idx in array) {
    callback(array[idx]);
  }
}

// myEach([1,2,3,4], function(arg) { console.log(arg); });

function myMap(array, callback) {
  let res = [];
  myEach(array, function(el) {
    res.push(callback(el));
  });
  return res;
}

// console.log(myMap([1,2,3,4], function(arg) { return arg * 2; }));

function myInject(array, callback) {
  let accum = array[0];
  myEach(array.splice(1), function(el) {
    accum = callback(accum, el);
  });
  return accum;
}

// console.log(myInject([1,2,3,4], function(accum, arg) { return accum + arg; }));

function bubbleSort(array) {
  let sorted = false;
  while (sorted === false) {
    sorted = true;
    for(let idx in array) {
      if(idx === 0){
        continue;
      }
      if(array[idx - 1] > array[idx]) {
        let left = array[idx - 1];
        let right = array[idx];
        array[idx - 1] = right;
        array[idx] = left;
        sorted = false;
      }
    }
  }
  return array;
}

// console.log(bubbleSort([3,4,6,1,2]));

function substrings(string) {
  let res = [];
  let array = string.split('');
  for(let i in array) {
    let sub = array[i];
    res.push(sub);
    for(let j in array) {
      if (j <= i) { continue; }
      sub += array[j];
      res.push(sub);
    }
  }
  return res;
}

// console.log(substrings('cat'));

function range(start, end) {
  if (end < start) {
    return [];
  }

  let res = [start];
  res = res.concat(range(start + 1, end));
  return res;
}

// console.log(range(1, 3));

function exp(b, n) {
  if (n === 0) {
    return 1;
  }

  return b * exp(b, n - 1);
}

// console.log(exp(2, 6));

function fib(n) {
  if (n < 1) {
    return [];
  }
  if (n === 1) {
    return [1];
  }
  if (n === 2) {
    return [1, 1];
  }

  let arr = fib(n-1);
  arr.push(arr[arr.length - 1] + arr[arr.length - 2]);
  return arr;
}

// console.log(fib(4));

function bsearch(arr, tar) {
  if(arr.length === 0) {
    return;
  }

  let mid = Math.floor(arr.length / 2);
  let left = arr.slice(0, mid);
  let right = arr.slice(mid + 1, arr.length);

  if (arr[mid] === tar) {
    return mid;
  } else if (arr[mid] > tar) {
    return bsearch(left, tar);
  } else {
    return bsearch(right, tar) + mid + 1;
  }
}

// console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

function mergeSort(arr) {
  if (arr.length <= 1) { return arr; }

  let mid = Math.floor(arr.length / 2);
  let left = arr.slice(0, mid);
  let right = arr.slice(mid, arr.length);

  return merge(mergeSort(left), mergeSort(right));
}

function merge(left, right) {
  let res = [];
  while(left.length > 0 && right.length > 0) {
    if(left[0] < right[0]) {
      res.push(left.shift());
    } else {
      res.push(right.shift());
    }
  }
  res.push(...left);
  res.push(...right);
  return res;
}

// console.log(mergeSort([1,4,232,4,5,4,2,3]));

function subsets(arr) {

  if (arr.length === 0) { return [[]]; }

  let res = [];
  let subs = subsets(arr.slice(0, arr.length - 1));
  let last = [arr[arr.length - 1]];

  res = subs;
  for(let i in subs) {
    res.push(subs[i].concat(last));
  }
  return res;
}

// console.log(subsets([]));
// console.log(subsets([1]));
// console.log(subsets([1,2]));
// console.log(subsets([1,2,3]));
