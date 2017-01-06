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
    if(this.props.creating) {
      this.props.createTodo(this.state);
    } else {
      this.props.updateTodo(this.state);
    }
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
      <div>
        <h3>{'Create new todo'}</h3>
        <form onSubmit={this.handleSubmit} id='todoform'>

          <label className='form-label'>
            Title:
          </label>
          <input type='text'
            className='form-input'
            onChange={this.handleInput('title')}></input>

          <label className='form-label'>
            Body:
          </label>
          <input type='text'
            className='form-input'
            onChange={this.handleInput('body')}></input>


          <label className='form-label'>
            {"Done?"}
          </label>
          <input type="checkbox"
            className='form-input'
            value="true"
            onChange={this.handleCheckbox}></input>

          <button type="submit" value="Submit" className='form-button'>Submit</button>
        </form>
      </div>
    );
  }
}

export default TodoForm;
