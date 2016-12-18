function Student(first, last) {
  this.first = first;
  this.last = last;
  this.courses = [];
}

Student.prototype.name = function() {
  return this.first + ' ' + this.last;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) === -1) {
    for(let i in this.courses) {
      if (this.courses[i].conflictsWith(course)) {
        return false;
      }
    }
    this.courses.push(course);
    return true;
  } else {
    return false;
  }
};

function Course(name, dept, credits, timeblock, days) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.timeblock = timeblock;
}

Course.prototype.addStudent = function(stud) {
  let valid = stud.enroll(this);
  if (valid === true) {
    this.students.push(stud);
  }
};

Course.prototype.conflictsWith = function(course) {
  if (this.timeblock === course.timeblock) {
    for(let i in this.days) {
      if (course.days.indexOf(this.days[i]) !== -1) {
        return true;
      }
    }
  }

  return false;
};

let stud1 = new Student('Abe', 'Lincoln');
let stud2 = new Student('JFK', 'NLN');

let c1 = new Course('Ruby1', 'CS', 3, 1, ['mon','wed','fri']);
let c2 = new Course('JS2', 'CS', 4, 3, ['mon', 'wed', 'fri']);
let c3 = new Course('History 3a', 'Hist', 1, 1, ['mon','tues']);

// console.log(c1.conflictsWith(c2));
// console.log(c1.conflictsWith(c3));


stud1.enroll(c2);
stud1.enroll(c3);
stud1.enroll(c1);

console.log(stud1.courses);

// c1.addStudent(stud1);
// c1.addStudent(stud2);
// c1.addStudent(stud1);
// c2.addStudent(stud1);
// c3.addStudent(stud1);
// c3.addStudent(stud1);

// console.log(stud1.courses);
// console.log(stud2.courses);
//
// console.log(c1.students);
// console.log(c2.students);
// console.log(c3.students);
