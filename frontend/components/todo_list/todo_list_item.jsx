import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.props.todo;
    this.handleDelete = this.handleDelete.bind(this);
    this.handleDone = this.handleDone.bind(this);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.removeTodo(this.state);
  }

  handleDone(e) {
    e.preventDefault();
    if (this.state.done) {
      this.setState({
        done: false
      });
    } else {
      this.setState({
        done: true
      });
    }

    this.props.receiveTodo(this.state);
  }

  render() {
    return (
      <li key={this.state.id}>{this.state.title}
        <button type="button" onClick={this.handleDone}>{this.state.done === false ? "done" : "undo"}</button>
        <button type="button" onClick={this.handleDelete}>Delete</button>
      </li>
    );
  }
}

export default TodoListItem;
