import React from 'react';
import ReactDOM from 'react-dom';

class Clock extends React.Component{
  constructor(){
    super();
    let date = new Date();
    this.state = {initial: date};
    this.intervalID = 0;
  }

  incrementSeconds(){
    let date = this.state.initial
    date.setSeconds(date.getSeconds() + 1);
    this.setState({initial: date});

  }

  componentDidMount(){
    setInterval(()=>{this.incrementSeconds()}, 1000);
  }

  render() {
    return (
      <div>
        <ul>
          <h1>Time:</h1>
          <h1 className="time">{this.state.initial.toTimeString()}</h1>
        </ul>
        <ul>
          <h1>Date:</h1>
          <h1 className="time">{this.state.initial.toDateString()}</h1>
        </ul>
      </div>
    );
  }
}

export default Clock;
