import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.handleCheckbox = this.handleCheckbox.bind(this);
    this.initialState = this.initialState.bind(this);
  }

  uniqueId() {
    return new Date().getTime();
  }

  initialState() {
    return {
      id: this.uniqueId(),
      title: '',
      body: '',
      done: false
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createTodo(this.state);
    this.setState(this.initialState());
    document.getElementById('todoform').reset();
  }

  handleInput(field) {
    return e => {
      this.setState({
        [field]: e.target.value
      });
    };
  }

  handleCheckbox(e) {
    if(e.target.checked) {
      this.setState({ done: true });
    } else {
      this.setState({ done: false });
    }
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit} id='todoform'>
        <label>
          Title:
          <input type='text' onChange={this.handleInput('title')}></input>
        </label>

        <label>
          Body:
          <input type='text' onChange={this.handleInput('body')}></input>
        </label>

        <label>
          {"Done?"}
          <input type="checkbox" value="true" onChange={this.handleCheckbox}></input>
        </label>

        <button type="submit" value="Submit">Submit</button>
      </form>
    );
  }
}

export default TodoForm;
