const read = require('readline');
const reader = read.createInterface({
  input: process.stdin,
  output: process.stdout,
});

var addNumbers = function(sum, numsLeft, completionCallback)  {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  }else if (numsLeft > 0) {
    reader.question("what's the num: ", function(ans) {
      let integ = parseInt(ans);
      sum += integ;
      numsLeft--;
      addNumbers(sum, numsLeft, completionCallback);
    });


  }
};


addNumbers(0, 3, sum => {
  console.log(`Total Sum: ${sum}`);
});
