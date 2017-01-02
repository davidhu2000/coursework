import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    console.log('TodoFormConstructor');
    console.log(this.props);
    this.state = {
      id: this.uniqueId(),
      title: '',
      body: '',
      done: false
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.handleCheckbox = this.handleCheckbox.bind(this);
  }

  uniqueId() {
    return new Date().getTime();
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.receiveTodo(this.state);
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
      <form onSubmit={this.handleSubmit}>
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
