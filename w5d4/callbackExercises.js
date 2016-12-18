class Clock {
 constructor() {
   // 1. Create a Date object.
   // 2. Store the hours, minutes, and seconds.
   // 3. Call printTime.
   // 4. Schedule the tick at 1 second intervals.
   let date = new Date();
   this.hours = date.getHours();
   this.minutes = date.getMinutes();
   this.seconds = date.getSeconds();

   this.printTime();
   setInterval(this._tick.bind(this), 1000);
 }

 printTime() {
   // Format the time in HH:MM:SS
   // Use console.log to print it.
   console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
 }

 _tick() {
   // 1. Increment the time by one second.
   // 2. Call printTime.
   this.seconds++;
   if(this.seconds >= 60) {
     this.minutes++;
     this.seconds -= 60;
   }
   if(this.minutes >= 60) {
     this.hours++;
     this.minutes -= 60;
   }
   this.printTime();
 }
}

const clock = new Clock();

// for (let i = 0; i < 1000; i++) {
// setInterval(clock._tick.bind(clock), 1000);
// }
